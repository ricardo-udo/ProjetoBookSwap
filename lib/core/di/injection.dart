import 'package:get_it/get_it.dart';

import 'package:book_swap/data/repositories/auth_repository.dart';
import 'package:book_swap/data/repositories/books_repository.dart';
import 'package:book_swap/data/repositories/user_repository.dart';
import 'package:book_swap/providers/auth_provider.dart';
import 'package:book_swap/providers/book_provider.dart';
import 'package:book_swap/providers/chat_provider.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Repositories (singletons)
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<BooksRepository>(() => BooksRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

  // Providers recebem repositórios via injeção de dependência
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<BookProvider>(
    () => BookProvider(repository: getIt<BooksRepository>()),
  );
  getIt.registerLazySingleton<ChatProvider>(() => ChatProvider());
}
