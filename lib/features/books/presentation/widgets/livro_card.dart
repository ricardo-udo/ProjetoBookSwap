import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/tela_detalhes_livro.dart';

enum LivroStatus {
  available,
  negotiating,
  sold,
}

class LivroCard extends StatelessWidget {
  final String userName;
  final String bookName;
  final String bookGenre;
  final String bookAuthor;
  final String bookImageUrl;
  final LivroStatus status;
  final void Function(BuildContext) onProposeTrade;
  final void Function(Book) onViewDetails;

  const LivroCard({
    super.key,
    required this.userName,
    required this.bookName,
    required this.bookGenre,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.status,
    required this.onProposeTrade,
    required this.onViewDetails,
  });

  Color _getStatusColor() {
    switch (status) {
      case LivroStatus.available:
        return const Color(0xFF2ECC71);
      case LivroStatus.negotiating:
        return const Color(0xFFF39C12);
      case LivroStatus.sold:
        return const Color(0xFF7F8597);
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case LivroStatus.available:
        return 'Disponível';
      case LivroStatus.negotiating:
        return 'Em negociação';
      case LivroStatus.sold:
        return 'Vendido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Publicado por',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF7F8597),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF181B31),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusLabel(),
                  style: textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  bookImageUrl,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Nome', bookName, textTheme),
                    const SizedBox(height: 10),
                    _buildInfoRow('Gênero', bookGenre, textTheme),
                    const SizedBox(height: 10),
                    _buildInfoRow('Autor', bookAuthor, textTheme),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => onProposeTrade(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2ECC71),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              'Propor troca',
                              style: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onViewDetailsPressed(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF2ECC71),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              'Ver detalhes',
                              style: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2ECC71),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onViewDetailsPressed() {
    final book = Book(
      title: bookName,
      author: bookAuthor,
      genre: bookGenre,
      year: 1954, // Mock data
      pages: 1216, // Mock data
      synopsis: 'Uma jornada épica através da Terra Média...', // Mock data
      imageUrl: bookImageUrl,
      ownerName: userName,
      ownerAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80', // Mock data
      status: status.name,
      publisher: 'Editora Mock', // Mock data
    );
    onViewDetails(book);
  }

  Widget _buildInfoRow(String label, String value, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: const Color(0xFF7F8597),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF181B31),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
