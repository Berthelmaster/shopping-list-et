import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

import '../locator.dart';
import '../repositories/shopping_list_item_repository.dart';

class ImagePreviewViewModel extends ChangeNotifier{
  var shoppingListItemRepository = locator.get<ShoppingListItemRepository>();
  bool loading = false;



  Future<void> sendImage(int shoppingListId, XFile? image) async{
    setLoading(true);

    await shoppingListItemRepository.getItemsByImage(shoppingListId, image);

    setLoading(false);
  }

  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }
}