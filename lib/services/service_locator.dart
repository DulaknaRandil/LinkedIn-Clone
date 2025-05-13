import 'package:get_it/get_it.dart';
import 'package:ilabs_assignment/services/data_service.dart';
import 'api_service.dart';
import 'analytics_service.dart';
import 'storage_service.dart';
import '../routing/navigation_service.dart';

// Service locator instance
final GetIt locator = GetIt.instance;

/// Setup all the services used in the app
void setupServiceLocator() {
  // Register services as singletons
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DataService());
}
