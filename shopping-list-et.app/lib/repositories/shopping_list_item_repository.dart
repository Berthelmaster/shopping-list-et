import '../models/item.dart';
import 'dart:convert';
import '../environment.dart';
import '../models/shopping_list.dart';
import 'package:http/http.dart' as http;

class ShoppingListItemRepository{
  Future<void> updateChecked(int id, bool? newValue) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglistitem/check?itemId=$id&isChecked=$newValue");

    var response = await http.put(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });
  }

}