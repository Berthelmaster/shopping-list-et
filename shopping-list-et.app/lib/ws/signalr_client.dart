import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import '../environment.dart';
import 'package:event/event.dart';
import 'dart:convert';

class SignalrClient{
  late HubConnection hubConnection;
  bool connected = false;
  Event onShoppingListUpdatedEvent = Event();
  Event<ShoppingListItemEventArgs> onShoppingListItemUpdatedEvent = Event<ShoppingListItemEventArgs>();

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
    switch(hubConnection.state) {
      case HubConnectionState.Disconnected:
        hubConnection.start();
        break;
      case HubConnectionState.Connecting:
      // TODO: Handle this case.
        break;
      case HubConnectionState.Connected:
      // TODO: Handle this case.
        break;
      case HubConnectionState.Disconnecting:
        hubConnection.start();
        break;
      case HubConnectionState.Reconnecting:
        hubConnection.start();
        break;
      case null:
        hubConnection.start();
        break;

    }
  }

  void startHubConnection() {
    hubConnection.start();
    connected = true;
  }
  
  void setupEvents(){
    hubConnection.on("OnShoppingListChangedEvent", (argument) {
      onShoppingListUpdatedEvent.broadcast();
    });

    hubConnection.on("OnItemChangedEvent", (argument) {
      var shoppingListId = int.parse(argument![0].toString());
      onShoppingListItemUpdatedEvent.broadcast(ShoppingListItemEventArgs(shoppingListId));
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