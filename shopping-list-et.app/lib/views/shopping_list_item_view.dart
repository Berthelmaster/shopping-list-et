import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_item_view_model.dart';
import 'package:stacked/stacked.dart';

class ShoppingListItemView extends StatelessWidget{
  const ShoppingListItemView({super.key});

  @override
  Widget build(BuildContext context) {

    final shoppingListId = (ModalRoute.of(context)!.settings.arguments as ShoppingListItemViewArguments).shoppingListId;

    // TODO: implement build
    return ViewModelBuilder<ShoppingListItemViewModel>.reactive(
        viewModelBuilder: () => ShoppingListItemViewModel(),
        builder: (context, viewModel, child) =>
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Heloo!' + shoppingListId.toString()
            ),
          ),
          body: Center(
            child: Text(
                'Hello'
            ),
          ),
        )
    );
  }

}

class ShoppingListItemViewArguments{
  final int? shoppingListId;

  ShoppingListItemViewArguments(this.shoppingListId);
}