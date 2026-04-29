import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/tela_login.dart';
import '../features/books/presentation/pages/tela_livros_disponiveis.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TelaLogin(),
    ),
    GoRoute(
      path: '/livros',
      builder: (context, state) => const TelaLivrosDisponiveis(),
    ),
  ],
);