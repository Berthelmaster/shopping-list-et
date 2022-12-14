import 'package:get_it/get_it.dart';
import 'package:shopping_list_et_app/repositories/shopping_list_access_repository.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';
import 'life_cycle/life_cycle_watcher_context.dart';
import 'repositories/shopping_list_item_repository.dart';
import 'repositories/shopping_list_repository.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<SignalrClient>(() => SignalrClient());
  locator.registerLazySingleton<ShoppingListItemRepository>(() => ShoppingListItemRepository());
  locator.registerLazySingleton<ShoppingListRepository>(() => ShoppingListRepository());
  locator.registerLazySingleton<ShoppingListAccessRepository>(() => ShoppingListAccessRepository());

  var lifeCycleWatcherStrategy = LifeCycleWatcherContext().getLifeCycleWatcherStrategy();
  lifeCycleWatcherStrategy.init();
  locator.registerLazySingleton(() => lifeCycleWatcherStrategy);
}