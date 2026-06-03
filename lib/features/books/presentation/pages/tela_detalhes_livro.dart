import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:book_swap/features/books/data/models/book.dart';
import 'dart:io';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  /// Exibe capa do livro suportando URL, arquivo local e placeholder.
  Widget _buildBookImage({double width = 120, double height = 180}) {
    final path = book.imagePath ?? '';

    if (path.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.menu_book, size: 40, color: Colors.grey),
      );
    }

    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        ),
      );
    }

    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/livros'),
        ),
        title: const Text('Detalhes do Livro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: implementar compartilhamento
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookHeader(),
            const SizedBox(height: 20),
            _buildOwnerInfo(),
            const SizedBox(height: 20),
            _buildBookInfoCard(),
            const SizedBox(height: 20),
            _buildSynopsis(),
            const SizedBox(height: 20),
            _buildBookCondition(),
            const SizedBox(height: 40),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.go('/chat', extra: book),
            icon: const Icon(Icons.chat),
            label: const Text('Propor troca'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: implementar salvar favoritos
            },
            icon: const Icon(Icons.favorite),
            label: const Text('Salvar nos favoritos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: _buildBookImage(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusBadge(status: book.status),
              const SizedBox(height: 8),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'por ${book.author}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              if (book.genre != null && book.genre!.isNotEmpty)
                Chip(
                  label: Text(book.genre!),
                  backgroundColor: Colors.blue.shade100,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerInfo() {
    final avatar = book.ownerAvatar ?? '';
    return Row(
      children: [
        const Text(
          'Publicado por',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[300],
          backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
          child: avatar.isEmpty
              ? const Icon(Icons.person, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.ownerName ?? 'Desconhecido',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Membro desde 2020',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BookInfoItem(
              icon: Icons.calendar_today,
              label: 'Ano',
              value: book.year?.toString() ?? '—',
            ),
            const Divider(),
            BookInfoItem(
              icon: Icons.category,
              label: 'Gênero',
              value: book.genre ?? '—',
            ),
            const Divider(),
            BookInfoItem(
              icon: Icons.book,
              label: 'Páginas',
              value: book.pages?.toString() ?? '—',
            ),
            const Divider(),
            BookInfoItem(
              icon: Icons.person,
              label: 'Autor',
              value: book.author,
            ),
            const Divider(),
            BookInfoItem(
              icon: Icons.business,
              label: 'Editora',
              value: book.publisher ?? '—',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSynopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sinopse',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          book.synopsis ?? 'Sem sinopse disponível.',
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildBookCondition() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Livro em bom estado',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Sem rasuras ou páginas amassadas',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case 'available':
        color = Colors.green;
        text = 'Disponível';
        break;
      case 'negotiating':
        color = Colors.orange;
        text = 'Em negociação';
        break;
      case 'sold':
        color = Colors.red;
        text = 'Vendido';
        break;
      default:
        color = Colors.grey;
        text = 'Desconhecido';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class BookInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const BookInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
