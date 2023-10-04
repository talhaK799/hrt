import 'package:get_it/get_it.dart';
import 'package:hart/core/services/auth_service.dart';
import 'package:hart/core/services/database_service.dart';
import 'package:hart/core/services/firebase_storage_service.dart';
import 'package:hart/core/services/locato_storage_service.dart';
import 'package:hart/core/services/theme_shared_prefs.dart';
import 'package:hart/core/services/verification_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DatabaseService());
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(SharedPreferencesServices());
  locator.registerSingleton(VerificationService());
  locator.registerSingleton(FirebaseStorageService());
}
