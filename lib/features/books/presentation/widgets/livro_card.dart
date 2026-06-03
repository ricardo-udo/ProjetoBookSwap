import 'package:flutter/material.dart';
import 'package:book_swap/features/books/data/models/book.dart';
import 'dart:io';

class LivroCard extends StatelessWidget {
  final Book book;
  final void Function(Book) onProposeTrade;
  final void Function(Book) onViewDetails;

  const LivroCard({
    super.key,
    required this.book,
    required this.onProposeTrade,
    required this.onViewDetails,
  });

  Color _getStatusColor() {
    switch (book.status) {
      case 'available':
        return const Color(0xFF2ECC71);
      case 'negotiating':
        return const Color(0xFFF39C12);
      case 'sold':
        return const Color(0xFF7F8597);
      default:
        return const Color(0xFF7F8597);
    }
  }

  String _getStatusLabel() {
    switch (book.status) {
      case 'available':
        return 'Disponível';
      case 'negotiating':
        return 'Em negociação';
      case 'sold':
        return 'Vendido';
      default:
        return 'Indisponível';
    }
  }

  Color _getStatusBackgroundColor() {
    final c = _getStatusColor();
    // Color.r/g/b retornam double 0.0–1.0 no Flutter 3.x
    return Color.fromARGB(
      (0.18 * 255).round(),
      (c.r * 255).round(),
      (c.g * 255).round(),
      (c.b * 255).round(),
    );
  }

  /// Exibe a imagem do livro:
  /// - caminho local  → Image.file
  /// - URL http/https → Image.network
  /// - vazio/nulo     → ícone placeholder
  Widget _buildBookImage() {
    final path = book.imagePath ?? '';

    if (path.isEmpty) {
      return Container(
        width: 120,
        height: 180,
        color: Colors.grey[300],
        child: const Icon(Icons.menu_book, size: 40, color: Colors.grey),
      );
    }

    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        width: 120,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 120,
          height: 180,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        ),
      );
    }

    return Image.file(
      File(path),
      width: 120,
      height: 180,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: 120,
        height: 180,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
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
        boxShadow: const [
          BoxShadow(
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
                    book.ownerName ?? 'Desconhecido',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF181B31),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(),
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
                child: _buildBookImage(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Título', book.title, textTheme),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      'Gênero',
                      book.genre ?? '—',
                      textTheme,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow('Autor', book.author, textTheme),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => onProposeTrade(book),
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
                            onPressed: () => onViewDetails(book),
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

  Widget _buildInfoRow(String label, String value, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: const Color(0xFF7F8597),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF181B31),
          ),
        ),
      ],
    );
  }
}
