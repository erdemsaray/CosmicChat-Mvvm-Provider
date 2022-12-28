import 'package:get_it/get_it.dart';

import '../view_models.dart/chats_model.dart';
import '../view_models.dart/contacts_model.dart';
import '../view_models.dart/conversation_model.dart';
import '../view_models.dart/sign_in_model.dart';
import 'auth_service.dart';
import 'chat_service.dart';
import 'navigator_service.dart';
import 'storage_service.dart';

GetIt getIt = GetIt.instance;

setUpLocators() {
  getIt.registerLazySingleton(() => NavigatorService());

  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => StorageService());

  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => ConversationModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => ContactsModel());
}
