import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/livro_card.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'package:book_swap/providers/auth_provider.dart';
import '../../../../providers/book_provider.dart';


class TelaLivrosDisponiveis extends StatefulWidget {
  const TelaLivrosDisponiveis({super.key});

  @override
  State<TelaLivrosDisponiveis> createState() => _TelaLivrosDisponiveisState();
}

class _TelaLivrosDisponiveisState extends State<TelaLivrosDisponiveis> {
  @override
  void initState() {
    super.initState();
    // Carrega os livros do banco ao abrir a tela
    Future.microtask(() {
      context.read<BookProvider>().loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(Icons.menu_book_outlined, color: Color(0xFF2C3A66), size: 30),
            const SizedBox(width: 12),
            Text('BookSwap', style: textTheme.titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home_outlined, color: Colors.black87)),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline, color: Colors.black87)),
              Positioned(right: 10, top: 10, child: Container(width: 18, height: 18, decoration: const BoxDecoration(color: Color(0xFF2C3A66), shape: BoxShape.circle), alignment: Alignment.center, child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
              child:  CircleAvatar(
                    radius: 45,

                    backgroundColor: Colors.blueAccent,

                    child: Text(
                      user?.name.isNotEmpty == true 
                          ? user!.name[0].toUpperCase (): 'U',

                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(textTheme),
              const SizedBox(height: 24),
              _buildFilterCard(context, textTheme),
              const SizedBox(height: 28),
              Consumer<BookProvider>(
                builder: (context, provider, child) {
                  return Text('${provider.books.length} livros disponíveis', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF181B31)));
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<BookProvider>(
                  builder: (context, provider, child) {
                    final books = provider.books;
                    if (books.isEmpty) {
                      return const Center(child: Text('Nenhum livro encontrado.'));
                    }
                    return ListView.separated(
                      itemCount: books.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return LivroCard(
                          book: book,
                          onProposeTrade: (selectedBook) => context.go('/chat', extra: selectedBook),
                          onViewDetails: (selectedBook) => context.go('/detalhes-livro', extra: selectedBook),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/cadastro-livro'),
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add, color: Color(0xFF2C3A66)),
        label: const Text('Adicionar Livro', style: TextStyle(color: Color(0xFF2C3A66))),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Livros Disponíveis', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF181B31))),
        const SizedBox(height: 8),
        Text('Encontre livros incríveis para trocar com outros leitores', style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF7F8597), height: 1.5)),
      ],
    );
  }

  Widget _buildFilterCard(BuildContext context, TextTheme textTheme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            _buildSearchField(context),
            const SizedBox(height: 16),
            _buildCategoryDropdown(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F4F8),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF7F8597)),
        hintText: 'Buscar por título ou autor...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildCategoryDropdown(TextTheme textTheme) {
    return DropdownButtonFormField<String>(
      items: const [
        DropdownMenuItem(value: 'Todos', child: Text('Todos')),
        DropdownMenuItem(value: 'Fantasia', child: Text('Fantasia')),
        DropdownMenuItem(value: 'Distopia', child: Text('Distopia')),
      ],
      onChanged: (_) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F4F8),
        labelText: 'Selecionar gênero',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}