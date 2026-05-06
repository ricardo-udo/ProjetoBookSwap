import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/livro_card.dart';

class TelaLivrosDisponiveis extends StatelessWidget {
  const TelaLivrosDisponiveis({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              color: Color(0xFF2C3A66),
              size: 30,
            ),
            const SizedBox(width: 12),
            Text(
              'BookSwap',
              style: textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home_outlined, color: Colors.black87),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black87,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C3A66),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: const SizedBox.shrink(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(textTheme),
                const SizedBox(height: 24),
                _buildFilterCard(context, textTheme),
                const SizedBox(height: 28),
                _buildAvailableText(textTheme),
                const SizedBox(height: 16),
                LivroCard(
                  userName: 'João Silva',
                  bookName: 'O Senhor dos Anéis',
                  bookGenre: 'Fantasia',
                  bookAuthor: 'J.R.R. Tolkien',
                  bookImageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=300&q=80',
                  status: LivroStatus.available,
                  onProposeTrade: (context) => context.go('/chat', extra: 'João Silva'),
                  onViewDetails: (book) => context.go('/detalhes-livro', extra: book),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFFFFFFFF),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar Livro'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Livros Disponíveis',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF181B31),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Encontre livros incríveis para trocar com outros leitores',
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF7F8597),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterCard(BuildContext context, TextTheme textTheme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchField(context),
            const SizedBox(height: 16),
            _buildCategoryDropdown(textTheme),
            const SizedBox(height: 18),
            Row(
              children: [
                _buildModeChip(
                  icon: Icons.grid_view,
                  label: 'Grade',
                  active: true,
                  context: context,
                ),
                const SizedBox(width: 12),
                _buildModeChip(
                  icon: Icons.list,
                  label: 'Lista',
                  active: false,
                  context: context,
                ),
              ],
            ),
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
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF9CA1B3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }

  Widget _buildCategoryDropdown(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F8),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Todas Categorias',
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF181B31),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7F8597)),
        ],
      ),
    );
  }

  Widget _buildModeChip({
    required IconData icon,
    required String label,
    required bool active,
    required BuildContext context,
  }) {
    final backgroundColor = active
        ? const Color(0xFF2C3A66)
        : const Color(0xFFF3F4F8);
    final foregroundColor = active ? Colors.white : const Color(0xFF2C3A66);

    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor),
            const SizedBox(width: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableText(TextTheme textTheme) {
    return Text(
      '8 livros encontrados',
      style: textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF7F8597),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
