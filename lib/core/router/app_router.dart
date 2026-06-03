import 'package:go_router/go_router.dart';
import 'package:book_swap/features/auth/presentation/pages/tela_login.dart';
import 'package:book_swap/features/auth/presentation/pages/tela_register.dart';
import 'package:book_swap/features/books/presentation/pages/tela_livros_disponiveis.dart';
import 'package:book_swap/features/books/presentation/pages/tela_cadastro_livro.dart';
import 'package:book_swap/features/books/presentation/pages/tela_detalhes_livro.dart';
import 'package:book_swap/features/chat/presentation/pages/tela_chat.dart';
import 'package:book_swap/features/profile/presentation/pages/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TelaLogin()),
    GoRoute(path: '/cadastro', builder: (context, state) => const TelaRegister()),
    GoRoute(path: '/livros', builder: (context, state) => const TelaLivrosDisponiveis()),
    GoRoute(path: '/cadastro-livro', builder: (context, state) => const TelaCadastroLivro()),
    GoRoute(
      path: '/detalhes-livro',
      builder: (context, state) => BookDetailPage(book: state.extra as dynamic),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatScreen(book: state.extra as dynamic),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
  ],
);