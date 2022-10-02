import '../environment.dart';
import 'package:http/http.dart' as http;

class ShoppingListAccessRepository{


  Future<RequestAccessResponse> requestAccess(String accessCode) async{
    var uri = Uri.parse("$httpBaseAddress/api/v1/shoppinglistaccess?accessCode=$accessCode");

    var response = await http.get(uri, headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });

    var success = response.statusCode == 200;

    return RequestAccessResponse(response.body, success);
  }
}

class RequestAccessResponse{
  final String token;
  final bool success;

  RequestAccessResponse(this.token, this.success);
}