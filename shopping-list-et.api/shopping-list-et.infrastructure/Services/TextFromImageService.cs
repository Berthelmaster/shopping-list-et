using Microsoft.Azure.CognitiveServices.Vision.ComputerVision;
using Microsoft.Azure.CognitiveServices.Vision.ComputerVision.Models;
using Microsoft.Extensions.Logging;
using System.Diagnostics;

namespace shopping_list_et.infrastructure.Services
{
    public class TextFromImageService
    {
        private readonly TextFromImageConfiguration configuration;
        private readonly ILogger<TextFromImageService> logger;

        public TextFromImageService(TextFromImageConfiguration configuration, ILogger<TextFromImageService> logger)
        {
            this.configuration = configuration;
            this.logger = logger;
        }

        public async Task<IReadOnlyList<string>> GetText(Stream file, CancellationToken cancellationToken)
        {
            var clientCredentials = new ApiKeyServiceClientCredentials(configuration.SubscriptionKey);

            using var client = new ComputerVisionClient(clientCredentials) 
            { 
                Endpoint = configuration.Endpoint
            };

            var stopwatch1 = new Stopwatch();

            stopwatch1.Start();
            var textHeaders = await client.ReadInStreamAsync(file, language: "da", cancellationToken: cancellationToken);


            string operationLocation = textHeaders.OperationLocation;

            const int numberOfCharsInOperationId = 36;
            string operationId = operationLocation.Substring(operationLocation.Length - numberOfCharsInOperationId);

            stopwatch1.Stop();

            logger.LogInformation("Api request took: {milliseconds}", stopwatch1.ElapsedMilliseconds);


            var stopwatch2 = new Stopwatch();
            stopwatch2.Start();

            ReadOperationResult results;
            do
            {
                results = await client.GetReadResultAsync(Guid.Parse(operationId));
                logger.LogInformation("Operation is: {status}", results.Status);
            }
            while ((results.Status == OperationStatusCodes.Running ||
                results.Status == OperationStatusCodes.NotStarted));

            stopwatch2.Stop();

            logger.LogInformation("Read result took: {milliseconds}", stopwatch2.ElapsedMilliseconds);

            var stopwatch3 = new Stopwatch();
            stopwatch3.Start();
            var textPages = results.AnalyzeResult.ReadResults;

            var textLines = new List<string>();
            foreach (var page in textPages)
            {
                foreach (var line in page.Lines)
                {
                    textLines.Add(line.Text);
                }
            }

            stopwatch3.Stop();
            logger.LogInformation("Analyze result took: {milliseconds}", stopwatch3.ElapsedMilliseconds);

            return textLines;
        }
    }
}
