import 'package:flutter/widgets.dart';

import '../locator.dart';
import '../models/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';

class ShoppingListViewModel extends ChangeNotifier{
  List<ShoppingList> shoppingLists = <ShoppingList>[];
  var shoppingListRepository = locator.get<ShoppingListRepository>();

  void initialise() async {
    shoppingLists = await shoppingListRepository.getAll();
  }
}