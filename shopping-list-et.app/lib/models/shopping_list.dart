import 'item.dart';

class ShoppingList{
  final int id;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Item> items;

  ShoppingList(this.id, this.active, this.createdAt, this.updatedAt, this.items);

  ShoppingList.fromJson(Map<String, dynamic> json)
          : id = json["id"],
            active = json["active"],
            createdAt = json["createdAt"],
            updatedAt = json["updatedAt"],
            items = json["items"];
}