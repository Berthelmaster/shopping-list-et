import 'package:flutter/material.dart';
import 'package:shopping_list_et_app/locator.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';

import 'life_cycle_watcher_strategy.dart';

class MobileLifeCycleWatcher
    extends WidgetsBindingObserver
    implements ILifeCycleWatcherStrategy {
  SignalrClient? signalrClient;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    print("State changed, current state: $state");

    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
      // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
      // TODO: Handle this case.
        break;
    }
  }

  void onResumed(){
    signalrClient!.checkConnection();
  }

  @override
  void init() {
    signalrClient = locator.get<SignalrClient>();
    WidgetsBinding.instance.addObserver(this);
  }

}