import 'package:shopping_list_et_app/ws/signalr_client.dart';
import '../locator.dart';
import 'life_cycle_watcher.dart';
import 'package:universal_html/html.dart' as html;


class WebLifeCycleWatcher with ILifeCycleWatcher{
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