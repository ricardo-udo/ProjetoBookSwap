import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_swap/core/di/injection.dart';
import 'package:book_swap/core/router/app_router.dart';
import 'package:book_swap/core/theme/app_theme.dart';
import 'package:book_swap/providers/auth_provider.dart';
import 'package:book_swap/providers/book_provider.dart';
import 'package:book_swap/providers/chat_provider.dart';
import 'package:book_swap/core/database/database_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initDatabase();           // ← Inicialização FFI
  
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<BookProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ChatProvider>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'BookSwap',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
      ),
    );
  }
}