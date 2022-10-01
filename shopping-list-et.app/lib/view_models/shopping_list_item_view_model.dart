import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/repositories/shopping_list_item_repository.dart';

import '../locator.dart';
import '../models/shopping_list.dart';
import '../repositories/shopping_list_repository.dart';
import '../ws/signalr_client.dart';

class ShoppingListItemViewModel extends ChangeNotifier{
  var shoppingListItemRepository = locator.get<ShoppingListItemRepository>();
  var shoppingListRepository = locator.get<ShoppingListRepository>();
  var signalrClient = locator.get<SignalrClient>();
  ShoppingList? shoppingList;
  bool modelReady() => shoppingList != null;
  final addItemFormFieldController = TextEditingController();

  Future<void> initializeOrCreateShoppingList(int? shoppingListId) async {
    signalrClient.onShoppingListItemUpdatedEvent.subscribe(onShoppingListItemUpdated);

    if(shoppingListId != null) {
      shoppingList = await shoppingListRepository.getById(shoppingListId);

    }else{
      shoppingList = await shoppingListRepository.create();
    }

    filterShoppingListItemsByChecked(shoppingList);

    notifyListeners();

  }

  Future<void> setCheckedValue(int id, bool? newValue) async{
    await shoppingListItemRepository.updateChecked(id, newValue);
  }

  void onShoppingListItemUpdated(ShoppingListItemEventArgs? args) async{
    if(shoppingList!.id != args!.shoppingListId) {
      return;
    }

    shoppingList = await shoppingListRepository.getById(shoppingList!.id);

    filterShoppingListItemsByChecked(shoppingList);

    notifyListeners();
  }

  Future<void> addItemButtonClicked() async{
    var myText = addItemFormFieldController.text;

    await shoppingListItemRepository.addItem(myText, shoppingList!.id);
  }

  void filterShoppingListItemsByChecked(ShoppingList? shoppingList){
    shoppingList!.items!.sort((a,b) {
      return a.checked.toString().compareTo(b.checked.toString());
    });
  }

  @override
  void dispose() async{
    signalrClient.onShoppingListItemUpdatedEvent.unsubscribe(onShoppingListItemUpdated);

    super.dispose();
  }

}