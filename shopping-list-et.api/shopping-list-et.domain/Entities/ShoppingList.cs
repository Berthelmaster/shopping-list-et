using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.domain.Entities
{
    public class ShoppingList
    {
        public int Id { get; set; }
        public bool Active { get; set; }
        public string? Name { get; set; }
        public int? ItemsCount => Items?.Count ?? 0;
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public List<Item>? Items { get; set; }
    }
}
