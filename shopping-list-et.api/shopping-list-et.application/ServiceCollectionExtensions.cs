using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using MediatR;
using Microsoft.Extensions.DependencyInjection;

namespace shopping_list_et.application
{
    public static class ServiceCollectionExtensions
    {
        public static void AddApplicationServiceCollection(this IServiceCollection serviceCollection)
        {
            serviceCollection.AddMediatR(typeof(ServiceCollectionExtensions).Assembly);
        }
    }
}
