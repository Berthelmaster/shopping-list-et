import 'package:flutter/widgets.dart';

import '../locator.dart';
import '../repositories/shopping_list_access_repository.dart';
import '../sp.dart';

class ShoppingListAccessViewModel extends ChangeNotifier{
  var shoppingListAccessRepository = locator.get<ShoppingListAccessRepository>();
  final accessButtonClickedController = TextEditingController();

  Future<bool> requestAccess(String? accessCode) async{

    if(accessCode == null || accessCode == "") {
      return false;
    }

    var response = await shoppingListAccessRepository.requestAccess(accessCode);

    if(!response.success) {
      return false;
    }

    await setAccessToken(response.token);

    return true;
  }
}