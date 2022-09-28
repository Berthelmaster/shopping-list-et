import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';

import '../locator.dart';
import '../models/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';

class ShoppingListViewModel extends ChangeNotifier{
  List<ShoppingList> shoppingLists = <ShoppingList>[];
  var shoppingListRepository = locator.get<ShoppingListRepository>();
  var signalrClient = locator.get<SignalrClient>();

  void initialise() async {
    shoppingLists = await shoppingListRepository.getAll();


  }

  void OnItemListChanged() async {
    shoppingLists = await shoppingListRepository.getAll();

    notifyListeners();
  }
}