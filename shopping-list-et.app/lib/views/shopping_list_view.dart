import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list_et_app/view_models/shopping_list_view_model.dart';
import 'package:stacked/stacked.dart';

class ShoppingListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<ShoppingListViewModel>.reactive(
      viewModelBuilder: () => ShoppingListViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) =>
        Scaffold(
          appBar: AppBar(
            title: Text(
              "HellO!"
            ),
          ),
          body: ListView.builder(
            itemCount: viewModel.shoppingLists.length,
              itemBuilder: (BuildContext context, int index){
              return Container(
                height: 100,
                child: Center(
                  child: Text(
                    viewModel.shoppingLists[index].id.toString()
                  ),
                ),
              );
              }
          )
        )
    );
  }

}