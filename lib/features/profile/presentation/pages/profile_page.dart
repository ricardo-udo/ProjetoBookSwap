import 'package:flutter/material.dart';
import 'package:book_swap/features/books/data/models/book.dart';
import 'package:provider/provider.dart';
import 'package:book_swap/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/book_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final bookProvider = context.watch<BookProvider>();
    final user = authProvider.user;
    final books = bookProvider.books
        .where((book) => book.ownerId == user?.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),

        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logout();

              context.go('/');
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,

                    backgroundColor: Colors.blueAccent,

                    child: Text(
                      user?.name.substring(0, 1).toUpperCase() ?? 'U',

                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    user?.name ?? 'Usuário',

                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    user?.email ?? 'email@email.com',

                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Livros anunciados",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            if (books.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Você ainda não anunciou livros.'),
                ),
              )
            else
              ...books.map(
                (book) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book),

                    title: Text(book.title),

                    subtitle: Text(book.author),
                  ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
