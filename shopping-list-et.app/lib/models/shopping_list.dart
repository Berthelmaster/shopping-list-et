import 'item.dart';
import 'dart:convert';

class ShoppingList{
  final int id;
  final bool active;
  final String? name;
  final int? itemsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item>? items;

  ShoppingList(this.id, this.active, this.name,this.itemsCount, this.createdAt, this.updatedAt, this.items);

  ShoppingList.fromJson(Map<String, dynamic> json)
          : id = json["id"],
            active = json["active"],
            name = json["name"] ?? "TestName",
            itemsCount = json["itemsCount"],
            createdAt = json["createdAt"] != null
                ? DateTime.parse(json["createdAt"])
                : DateTime.now(), // Dummy
            updatedAt = json["updatedAt"] != null
                ? DateTime.parse(json["updatedAt"])
                : DateTime.now() , // Dummy
            items = json["items"] != null
                ? (json["items"] as List).map((e) => Item.fromJson(e)).toList()
                : null;
}