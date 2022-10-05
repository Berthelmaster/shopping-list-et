import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'life_cycle_watcher_strategy.dart';
import 'mobile_life_cycle_watcher.dart';
import 'web_life_cycle_watcher.dart';

class LifeCycleWatcherContext {
  ILifeCycleWatcherStrategy getRuntimeLifeCycleStrategy(){
    if(kIsWeb) {
      return WebLifeCycleWatcher();
    }
    if(Platform.isAndroid || Platform.isIOS) {
      return MobileLifeCycleWatcher();
    }

    throw ArgumentError();
  }
}