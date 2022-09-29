import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/repositories/shopping_list_item_repository.dart';

import '../locator.dart';
import '../models/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';

class ShoppingListItemViewModel extends ChangeNotifier{
  var shoppingListItemRepository = locator.get<ShoppingListItemRepository>();
  var shoppingListRepository = locator.get<ShoppingListRepository>();
  ShoppingList? shoppingList;
  bool modelReady() => shoppingList != null;

  Future<void> initializeOrCreateShoppingList(int? shoppingListId) async {
    if(shoppingListId != null) {
      shoppingList = await shoppingListRepository.getById(shoppingListId);
    }else{
      shoppingList = await shoppingListRepository.create();
    }

    notifyListeners();

  }

}