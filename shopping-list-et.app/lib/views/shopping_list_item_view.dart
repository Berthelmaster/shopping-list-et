import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_item_view_model.dart';
import 'package:stacked/stacked.dart';

class ShoppingListItemView extends StatelessWidget{
  const ShoppingListItemView({super.key});

  @override
  Widget build(BuildContext context) {

    final shoppingListId = ModalRoute.of(context)!.settings.arguments != null
        ? (ModalRoute.of(context)!.settings.arguments as ShoppingListItemViewArguments).shoppingListId
        : ShoppingListItemViewArguments(shoppingListId: null).shoppingListId;

    print(shoppingListId.toString());

    // TODO: implement build
    return ViewModelBuilder<ShoppingListItemViewModel>.reactive(
        viewModelBuilder: () => ShoppingListItemViewModel(),
        onModelReady: (viewModel) async => await viewModel.initializeOrCreateShoppingList(shoppingListId),
        builder: (context, viewModel, child) =>
        Scaffold(
          appBar: AppBar(
            title: Center(

              child: Text(
                viewModel.modelReady() == true ?
                "| ${viewModel.shoppingList!.name} |"
                    : "Loading..."
              ),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${viewModel.shoppingList!.items!.where((element) => !element.checked).length} varer mangler",
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Text(
                        "${viewModel.shoppingList!.items!.where((element) => element.checked).length} varer i kurven",
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Text(
                        "${viewModel.shoppingList!.itemsCount.toString()} varer i alt",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sidst redigeret: ${DateFormat("dd-MM-yyyy").format(viewModel.shoppingList!.updatedAt!)}"
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLength: 25,
                    autocorrect: true,

                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.add
                        ),
                        onPressed: () => print('ok'),
                      ),
                        labelText: "Tilføj vare",
                        labelStyle: TextStyle(
                        )
                    )
                  )

                ],
              ),
            )
          )
              : null
        )
    );
  }

}

class ShoppingListItemViewArguments{
  final int? shoppingListId;

  ShoppingListItemViewArguments({this.shoppingListId});
}