import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/view_models/image_preview_view_model.dart';
import 'package:stacked/stacked.dart';

class ImagePreviewView extends StatelessWidget{
  const ImagePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)!.settings.arguments
    as ImagePreviewArguments);

    print(arguments.image.name);
    print(arguments.image.path);

    // TODO: implement build
    return ViewModelBuilder<ImagePreviewViewModel>.reactive(
    viewModelBuilder: () => ImagePreviewViewModel(),
    onModelReady: (viewModel) async => await viewModel.init(arguments.image),
    builder: (context, viewModel, child) =>
        Scaffold(
          body: Stack(
            children: [
              viewModel.image != null ?
              kIsWeb ? Image.memory(
                viewModel.image!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              )
              : Center(
                child: Image.file(
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  File(
                    arguments.image.path,
                  ),
                ),
              )
              : const CircularProgressIndicator(),
              viewModel.loading
                  ? const Center(
                  child: CircularProgressIndicator()
              )
              : Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: () async {
                            await viewModel.sendImage(arguments.shoppingListId, arguments.image);

                            Navigator.of(context).pop();
                          },
                          heroTag: 'preview-1',
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          heroTag: 'preview-2',
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );

  }

}


class ImagePreviewArguments{
  XFile image;
  int shoppingListId;

  ImagePreviewArguments(this.image, this.shoppingListId);
}