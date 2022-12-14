class Item{
  final int id;
  final String text;
  final DateTime createdAt;
  bool checked;

  Item(this.id, this.text, this.createdAt, this.checked);

  Item.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        text = json["text"],
        createdAt = DateTime.parse(json["createdAt"]),
        checked = json["checked"];
}