class Item{
  final int id;
  final String text;
  final DateTime createdAt;
  final bool checked;

  Item(this.id, this.text, this.createdAt, this.checked);

  Item.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        text = json["text"],
        createdAt = json["createdAt"],
        checked = json["checked"];
}