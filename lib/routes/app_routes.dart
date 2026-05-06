import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/tela_login.dart';
import '../features/books/presentation/pages/tela_livros_disponiveis.dart';
import '../features/books/presentation/pages/tela_detalhes_livro.dart';
import '../features/chat/presentation/pages/tela_chat.dart';

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
    GoRoute(
      path: '/detalhes-livro',
      builder: (context, state) => BookDetailPage(book: state.extra as Book),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatScreen(
        userName: state.extra as String? ?? 'Usuário',
      ),
    ),
  ],
);
