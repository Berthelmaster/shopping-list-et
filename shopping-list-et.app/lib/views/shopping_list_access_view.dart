import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_item_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view_models/shopping_list_access_view_model.dart';

class ShoppingListAccessView extends StatelessWidget {
  const ShoppingListAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return ViewModelBuilder<ShoppingListAccessViewModel>.reactive(
      viewModelBuilder: () => ShoppingListAccessViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          body: Center(
            child: Container(
              width: width * 0.7,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center, children: [
                TextFormField(
                    maxLength: 25,
                    controller: viewModel.accessButtonClickedController,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: "Indtast adgangskode",
                    )),
                TextButton(
                    onPressed: () async {
                      var success = await viewModel.requestAccess(viewModel.accessButtonClickedController.text);

                      if(!success) {
                        print('øv');
                        Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          msg: "Ahhh, prøv lige igen!"
                        );

                        return;
                      }

                      await Navigator.popAndPushNamed(context, '/shoppingLists');
                    },
                    child: Text('Klik mig')
                )
              ]
              ),
            ),
      )),
    );
  }
}
