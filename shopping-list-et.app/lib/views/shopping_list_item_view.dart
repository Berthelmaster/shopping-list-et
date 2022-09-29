import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_item_view_model.dart';
import 'package:stacked/stacked.dart';

class ShoppingListItemView extends StatelessWidget{
  const ShoppingListItemView({super.key});

  @override
  Widget build(BuildContext context) {

    final shoppingListId = ModalRoute.of(context)!.settings.arguments != null
        ? (ModalRoute.of(context)!.settings.arguments as ShoppingListItemViewArguments).shoppingListId
        : ShoppingListItemViewArguments(null).shoppingListId;

    // TODO: implement build
    return ViewModelBuilder<ShoppingListItemViewModel>.reactive(
        viewModelBuilder: () => ShoppingListItemViewModel(),
        onModelReady: (viewModel) async => await viewModel.initializeOrCreateShoppingList(shoppingListId),
        builder: (context, viewModel, child) =>
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Heloo!'
            ),
              bottom: viewModel.modelReady() == false
                  ? PreferredSize(
                  preferredSize: const Size.fromHeight(6.0),
                  child: LinearProgressIndicator(
                      backgroundColor: Colors.red.withOpacity(0.6),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue)
                  )
              )
                  : null
          ),
          body: viewModel.modelReady() == true
              ? Center(
            child: Text(
                "Hello ${viewModel.shoppingList!.name}"
            ),
          )
              : null
        )
    );
  }

}

class ShoppingListItemViewArguments{
  final int? shoppingListId;

  ShoppingListItemViewArguments(this.shoppingListId);
}