import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_list_et_app/repositories/shopping_list_item_repository.dart';

import '../locator.dart';
import '../models/item.dart';
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

  final titleFormController = TextEditingController();

  // Variables for camera access, control, photos
  CameraController? cameraController;
  List<CameraDescription>? _cameras;
  var cameraOn = false;
  var currentCameraPosition = 0;
  var cameraButtonsClickable = true;
  late int availableCameraPositions;

  Future<void> initializeOrCreateShoppingList(int? shoppingListId) async {
    signalrClient.onShoppingListItemUpdatedEvent.subscribe(onShoppingListItemUpdated);
    signalrClient.onShoppingListUpdatedEvent.subscribe(onShoppingListUpdated);

    if(shoppingListId != null) {
      shoppingList = await shoppingListRepository.getById(shoppingListId);

    }else{
      shoppingList = await shoppingListRepository.create();
    }

    filterShoppingListItemsByChecked(shoppingList);

    notifyListeners();

  }

  Future<void> toggleCamera() async{
    if(!cameraOn){
      _cameras = await availableCameras();

      // Only use back Camera
      var backCamera = _cameras!.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

      cameraController = CameraController(backCamera, ResolutionPreset.max);
      await cameraController!.initialize();
      cameraOn = true;
    }else{
      await cameraController!.dispose();
      cameraOn = false;
    }

    notifyListeners();
  }

  // Dont use this, no need
  Future<void> nextCamera() async {
    cameraButtonsClickable = false;
    notifyListeners();

    currentCameraPosition = currentCameraPosition >= availableCameraPositions
        ? 0
        : currentCameraPosition+=1;
    cameraController = CameraController(_cameras![currentCameraPosition], ResolutionPreset.max);
    await cameraController!.initialize();
    cameraButtonsClickable = true;
    notifyListeners();
  }

  Future<XFile?> takePicture() async {
    if(cameraController!.value.isTakingPicture) {
      return null;
    }

    try{
      final XFile image = await cameraController!.takePicture();
      return image;
    } on CameraException catch(e){
      Fluttertoast.showToast(msg: e.description.toString());
      return null;
    }


  }

  Future<void> setCheckedValue(Item item) async{
    item.checked = !item.checked;
    notifyListeners();

    await shoppingListItemRepository.updateChecked(item.id, item.checked);
  }

  void onShoppingListItemUpdated(ShoppingListItemEventArgs? args) async{
    if(shoppingList!.id != args!.shoppingListId) {
      return;
    }

    shoppingList = await shoppingListRepository.getById(shoppingList!.id);

    filterShoppingListItemsByChecked(shoppingList);

    notifyListeners();
  }

  void onShoppingListUpdated(ShoppingListEventArgs? args) async{
    if(shoppingList!.id != args!.shoppingListId) {
      return;
    }

    shoppingList = await shoppingListRepository.getById(shoppingList!.id);

    filterShoppingListItemsByChecked(shoppingList);

    notifyListeners();
  }

  Future<void> removeItem(int id) async{
    await shoppingListItemRepository.removeItem(id);
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

  Future<void> modifyName(int shoppingListId) async{
    var newName = titleFormController.text;

    await shoppingListRepository.modifyNameById(shoppingListId, newName);
  }
  Future<XFile?> pickImageFromGallery() async{
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  @override
  void dispose() async{
    signalrClient.onShoppingListItemUpdatedEvent.unsubscribe(onShoppingListItemUpdated);
    signalrClient.onShoppingListUpdatedEvent.unsubscribe(onShoppingListUpdated);

    if(cameraController != null && cameraController!.value.isInitialized) {
      await cameraController!.dispose();
    }

    super.dispose();
  }

}