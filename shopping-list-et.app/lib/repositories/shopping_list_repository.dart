import 'dart:convert';

import '../environment.dart';
import '../models/shopping_list.dart';
import 'package:http/http.dart' as http;

class ShoppingListRepository{

  Future<List<ShoppingList>> getAll() async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglist/all");

    var response = await http.get(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    });

    var shoppingLists = List<ShoppingList>.from(json.decode(response.body).map((e) => ShoppingList.fromJson(e)));

    return shoppingLists;
  }

  Future<void> remove(int shoppingListId) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglist?id=$shoppingListId");

    var response = await http.delete(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    });
  }

  Future<ShoppingList> getById(int shoppingListId) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglist?id=$shoppingListId");

    var response = await http.get(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });

    return ShoppingList.fromJson(json.decode(response.body));
  }

  Future<ShoppingList> create() async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglist");

    var response = await http.post(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });

    return ShoppingList.fromJson(json.decode(response.body));
  }

}