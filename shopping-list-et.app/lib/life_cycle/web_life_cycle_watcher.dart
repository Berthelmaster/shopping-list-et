import 'package:shopping_list_et_app/ws/signalr_client.dart';
import '../locator.dart';
import 'life_cycle_watcher_strategy.dart';
import 'package:universal_html/html.dart' as html;


class WebLifeCycleWatcher with ILifeCycleWatcherStrategy{
  SignalrClient? signalrClient;
  int counter = 0;


  void onVisibilityChange(html.Event e) {
    signalrClient!.checkConnection();
  }

  @override
  void init() {
    html.document.addEventListener('visibilitychange', onVisibilityChange);
    signalrClient = locator.get<SignalrClient>();
  }

}