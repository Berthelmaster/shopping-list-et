import 'package:get_it/get_it.dart';
import 'package:shopping_list_et_app/ws/signalr_client.dart';

final locator = GetIt.instance;

void setup(){
  print("HIT2");
  locator.registerLazySingleton<SignalrClient>(() => SignalrClient());
}