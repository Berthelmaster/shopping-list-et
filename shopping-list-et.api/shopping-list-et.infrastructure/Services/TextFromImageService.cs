using Microsoft.Azure.CognitiveServices.Vision.ComputerVision;
using Microsoft.Azure.CognitiveServices.Vision.ComputerVision.Models;
using Microsoft.Extensions.Logging;

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

            var textHeaders = await client.ReadInStreamAsync(file, language: "da", cancellationToken: cancellationToken);

            string operationLocation = textHeaders.OperationLocation;

            const int numberOfCharsInOperationId = 36;
            string operationId = operationLocation.Substring(operationLocation.Length - numberOfCharsInOperationId);

            ReadOperationResult results;
            do
            {
                results = await client.GetReadResultAsync(Guid.Parse(operationId), cancellationToken: cancellationToken);
            }
            while ((results.Status == OperationStatusCodes.Running ||
                results.Status == OperationStatusCodes.NotStarted));

            var textPages = results.AnalyzeResult.ReadResults;

            var textLines = new List<string>();
            foreach (var page in textPages)
            {
                foreach (var line in page.Lines)
                {
                    textLines.Add(line.Text);
                }
            }

            return textLines;
        }
    }
}
