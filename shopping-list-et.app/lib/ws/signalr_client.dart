import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import '../environment.dart';

class SignalrClient{
  late HubConnection hubConnection;
  bool connected = false;

  SignalrClient(){
    hubConnection = HubConnectionBuilder()
        .withUrl("$httpBaseAddress/signalr/hub")
        .build();
    print("HIT");

    hubConnection.onreconnected(({connectionId}) {
      print("Reconnected");
      connected = true;
    });

    hubConnection.onclose(({error}) {
      print("closed");
      connected = false;
    });

    hubConnection.onreconnecting(({error}) {
      print("reconnecting...");
    });

    hubConnection.start();
    connected = true;
  }

  void checkConnection(){
    if(!connected){
      hubConnection.start();
      connected = true;
    }
  }


}