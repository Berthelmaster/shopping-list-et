import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_view_model.dart';
import 'package:shopping_list_et_app/views/shopping_list_item_view.dart';
import 'package:stacked/stacked.dart';

class ShoppingListView extends StatelessWidget{
  const ShoppingListView({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<ShoppingListViewModel>.reactive(
      viewModelBuilder: () => ShoppingListViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) =>
        Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Emma og Thomas' Indkøbslister <3"
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_business_outlined),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Navigator.pushNamed(context, '/shoppingListItem');
                },
              ),
            ],
            bottom: viewModel.displayMainLoadingIndicator() == true
                  ? PreferredSize(
              preferredSize: const Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.red.withOpacity(0.6),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue)
              )
            )
              : null
          ),
          body: ListView.builder(
            itemCount: viewModel.shoppingLists.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5
                  ),
                  child: GestureDetector(
                    onTap: () =>  Navigator.pushNamed(
                        context,
                        '/shoppingListItem',
                        arguments: ShoppingListItemViewArguments(shoppingListId: viewModel.shoppingLists[index].id)
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          //color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${viewModel.shoppingLists[index].itemsCount.toString()} varer"
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.shoppingLists[index].name.toString(),
                                  ),

                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                  "Sidst updateret"
                                  ),
                                  Text(
                                    DateFormat("dd-MM-yyyy").format(viewModel.shoppingLists[index].updatedAt!)
                                  )
                                  ],
                              ),
                              viewModel.shoppingListDeleteLoading.containsKey(viewModel.shoppingLists[index].id) == true
                                  ? IconButton(
                                onPressed: () async => viewModel.removeShoppingList(viewModel.shoppingLists[index].id),
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.grey,
                                ),
                              )
                                  : IconButton(
                                    onPressed: () async => viewModel.removeShoppingList(viewModel.shoppingLists[index].id),
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  )



                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          )
        )
    );
  }

}