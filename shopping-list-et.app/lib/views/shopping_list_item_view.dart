import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_item_view_model.dart';
import 'package:shopping_list_et_app/views/image_preview_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ShoppingListItemView extends StatelessWidget {
  const ShoppingListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListId = ModalRoute.of(context)!.settings.arguments != null
        ? (ModalRoute.of(context)!.settings.arguments
                as ShoppingListItemViewArguments)
            .shoppingListId
        : ShoppingListItemViewArguments(shoppingListId: null).shoppingListId;

    // TODO: implement build
    return ViewModelBuilder<ShoppingListItemViewModel>.reactive(
        viewModelBuilder: () => ShoppingListItemViewModel(),
        onModelReady: (viewModel) async =>
            await viewModel.initializeOrCreateShoppingList(shoppingListId),
        builder: (context, viewModel, child) => viewModel.cameraOn == true
            ? CameraPreview(
                viewModel.cameraController!,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () async =>
                              viewModel.cameraButtonsClickable
                                  ? Fluttertoast.showToast(msg: "Hvordan kan man tage en selfie af en opskrift?")
                                  : null,
                          backgroundColor: Colors.transparent,
                          heroTag: 'camera-switch',
                          child: const Icon(Icons.cameraswitch),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            if(!viewModel.cameraButtonsClickable) {
                              return;
                            }
                            var image = await viewModel.takePicture();

                            Navigator.pushNamed(
                                context,
                                '/imagePreview',
                                arguments: ImagePreviewArguments(
                                    image!,
                                  viewModel.shoppingList!.id
                                )
                            );
                          },

                          backgroundColor: Colors.transparent,
                          heroTag: 'camera-takePicture',
                          child: const Icon(Icons.camera_alt),
                        ),
                        FloatingActionButton(
                          onPressed: () async =>
                              viewModel.cameraButtonsClickable
                                  ? await viewModel.toggleCamera()
                                  : null,
                          backgroundColor: Colors.transparent,
                          heroTag: 'camera-exit',
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            viewModel.titleFormController.text = viewModel.shoppingList!.name.toString();
                            return AlertDialog(
                              title: const Text(
                                'Nyt Navn'
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                side: BorderSide(width: 3.0, color: Colors.white),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: viewModel.titleFormController,
                                    decoration:
                                        InputDecoration(hintText: 'Message'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () async {
                                          await viewModel.modifyName(viewModel.shoppingList!.id);
                                          Navigator.of(context).pop();
                                        },
                                        heroTag: 'popup-1',
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                        ),

                                      ),
                                      Spacer(),
                                      FloatingActionButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        heroTag: 'popup-2',
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        child: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      child: Text(viewModel.modelReady() == true
                          ? "| ${viewModel.shoppingList!.name} |"
                          : "Loading..."),
                    ),
                    bottom: viewModel.modelReady() == false
                        ? PreferredSize(
                            preferredSize: const Size.fromHeight(6.0),
                            child: LinearProgressIndicator(
                                backgroundColor: Colors.red.withOpacity(0.6),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue)))
                        : null),
                body: viewModel.modelReady() == true
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${viewModel.shoppingList!.items!.where((element) => !element.checked).length} varer mangler",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "${viewModel.shoppingList!.items!.where((element) => element.checked).length} varer i kurven",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "${viewModel.shoppingList!.itemsCount.toString()} varer i alt",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Sidst redigeret: ${DateFormat("dd-MM-yyyy").format(viewModel.shoppingList!.updatedAt!)}"),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                maxLength: 25,
                                autocorrect: true,
                                controller:
                                    viewModel.addItemFormFieldController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () async =>
                                          await viewModel.toggleCamera(),
                                    ),
                                    prefixIcon: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () async {
                                        await viewModel.addItemButtonClicked();
                                        FocusScope.of(context).unfocus();
                                        viewModel.addItemFormFieldController
                                            .clear();
                                      },
                                    ),
                                    labelText: "Tilføj vare",
                                    labelStyle: const TextStyle())),
                            Expanded(
                              child: ListView.separated(
                                  itemCount:
                                      viewModel.shoppingList!.items!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var currentItem =
                                        viewModel.shoppingList!.items![index];

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: Column(
                                            children: [
                                              Dismissible(
                                                key: Key(
                                                    currentItem.id.toString()),
                                                onDismissed: (direction) async {
                                                  await viewModel.removeItem(
                                                      currentItem.id);
                                                },
                                                child: CheckboxListTile(
                                                  title: Text(currentItem
                                                      .text), //    <-- label
                                                  value: currentItem.checked,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  onChanged: (newValue) async {
                                                    await viewModel
                                                        .setCheckedValue(
                                                            currentItem);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ))
                    : null));
  }
}

class ShoppingListItemViewArguments {
  final int? shoppingListId;

  ShoppingListItemViewArguments({this.shoppingListId});
}
