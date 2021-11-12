import 'package:get_it/get_it.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';

final GetIt locator = GetIt.instance;

void initializeLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
}
