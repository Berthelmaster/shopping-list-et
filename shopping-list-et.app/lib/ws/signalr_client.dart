import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import '../environment.dart';
import 'package:event/event.dart';

class SignalrClient{
  late HubConnection hubConnection;
  bool connected = false;
  Event onShoppingListUpdated = Event();
  Event<ShoppingListItemEventArgs> onShoppingListItemUpdated = Event<ShoppingListItemEventArgs>();

  SignalrClient(){

    if (kDebugMode) {
      print("using http base address: $httpBaseAddress");
    }

    hubConnection = HubConnectionBuilder()
        .withUrl("$httpBaseAddress/signalr/hub")
        .build();

    if (kDebugMode) {
      print("HIT");
    }

    setupConnectionChangeEvents();

    setupEvents();

    startHubConnection();
  }

  void checkConnection() {
    if (!connected) {
      hubConnection.start();
      connected = true;
    }
  }

  void startHubConnection() {
    hubConnection.start();
    connected = true;
  }
  
  void setupEvents(){
    hubConnection.on("OnShoppingListChangedEvent", (argument) {
      onShoppingListUpdated.broadcast();
    });

    hubConnection.on("OnItemChangedEvent", (argument) {
      var shoppingListId = int.parse(argument.toString());
      onShoppingListItemUpdated.broadcast(ShoppingListItemEventArgs(shoppingListId));
    });
  }

  void setupConnectionChangeEvents(){
    hubConnection.onreconnected(({connectionId}) {
      if (kDebugMode) {
        print("Reconnected");
      }
      connected = true;
    });

    hubConnection.onclose(({error}) {
      if (kDebugMode) {
        print("closed");
      }
      connected = false;
    });

    hubConnection.onreconnecting(({error}) {
      if (kDebugMode) {
        print("reconnecting...");
      }
    });
  }


}

class ShoppingListItemEventArgs extends EventArgs{
  int shoppingListId;

  ShoppingListItemEventArgs(this.shoppingListId);
}