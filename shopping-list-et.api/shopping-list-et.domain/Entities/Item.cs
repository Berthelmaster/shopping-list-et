namespace shopping_list_et.domain.Entities
{
    public class Item
    {
        public int? Id { get; set; }
        public string? Text { get; set; }
        public DateTime? CreatedAt { get; set; }
        public bool? Checked { get; set; }
        
        public int ShoppingListId { get; set; }
        public ShoppingList? ShoppingList { get; set; }
    }
}