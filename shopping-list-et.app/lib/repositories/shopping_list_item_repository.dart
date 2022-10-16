import 'dart:io';

import 'package:camera/camera.dart';

import '../models/item.dart';
import 'dart:convert';
import '../environment.dart';
import '../models/shopping_list.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ShoppingListItemRepository{
  Future<void> updateChecked(int id, bool? newValue) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglistitem/check?itemId=$id&isChecked=$newValue");

    var response = await http.put(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });
  }

  Future<void> addItem(String text, int shoppingListId) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglistitem?text=$text&shoppingListId=$shoppingListId");

    var response = await http.post(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });

  }

  Future<void> removeItem(int id) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglistitem?itemId=$id");

    var response = await http.delete(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });
  }


  Future<void> getItemsByImage(int shoppingListId, XFile? image) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/ImageTextRecognition?shoppingListId=$shoppingListId");

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        File(image!.path).readAsBytesSync(),
        filename: image.name,
          )
      );

    var response = await request.send();
  }

}