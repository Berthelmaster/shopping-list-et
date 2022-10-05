import 'package:shopping_list_et_app/ws/signalr_client.dart';
import '../locator.dart';
import 'life_cycle_strategy.dart';
import 'package:universal_html/html.dart' as html;


class WebLifeCycleWatcher with ILifeCycleStrategy{
  SignalrClient? signalrClient;


  void onVisibilityChange(html.Event e) {
    if(html.document.visibilityState == 'visible'){
      signalrClient!.checkConnection();
    }
  }

  @override
  void init() {
    html.document.addEventListener('visibilitychange', onVisibilityChange);
    signalrClient = locator.get<SignalrClient>();
  }

}