import 'package:get_it/get_it.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';
import 'repositories/shopping_list_item_repository.dart';
import 'repositories/shopping_list_repository.dart';

final locator = GetIt.instance;

void setup(){
  print("HIT2");
  locator.registerLazySingleton<SignalrClient>(() => SignalrClient());
  locator.registerLazySingleton<ShoppingListItemRepository>(() => ShoppingListItemRepository());
  locator.registerLazySingleton<ShoppingListRepository>(() => ShoppingListRepository());
}