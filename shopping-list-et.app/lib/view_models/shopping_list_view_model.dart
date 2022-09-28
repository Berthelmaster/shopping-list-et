import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';

import '../locator.dart';
import '../models/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';

class ShoppingListViewModel extends ChangeNotifier{
  List<ShoppingList> shoppingLists = <ShoppingList>[];
  var shoppingListRepository = locator.get<ShoppingListRepository>();
  var signalrClient = locator.get<SignalrClient>();
  var shoppingListDeleteLoading = HashMap<int, bool>();

  void initialise() async {
    shoppingLists = await shoppingListRepository.getAll();


  }

  void onItemListChanged() async {
    shoppingLists = await shoppingListRepository.getAll();

    shoppingListDeleteLoading.clear();

    notifyListeners();
  }

  Future<void> removeShoppingList(int shoppingListId) async {
    shoppingListDeleteLoading[shoppingListId] = true;

    notifyListeners();

    print(shoppingListId.toString());
  }
}