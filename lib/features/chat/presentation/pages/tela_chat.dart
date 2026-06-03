import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:book_swap/features/books/data/models/book.dart';
import 'package:book_swap/providers/chat_provider.dart';
import 'package:book_swap/providers/auth_provider.dart';

class ChatScreen extends StatefulWidget {

  final Book book;

  const ChatScreen({
    super.key,
    required this.book,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _messageController =
      TextEditingController();

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      final chatProvider =
          context.read<ChatProvider>();

      // cria chat fake se não existir
      if (chatProvider.chats.isEmpty) {

        chatProvider.createChat(

          bookId: widget.book.id,

          user1Id: 'me',

          user2Id: widget.book.ownerId,
        );
      }
    });
  }

  void _sendMessage() {

    if (_messageController.text.trim().isEmpty) {
      return;
    }

    final chatProvider =
        context.read<ChatProvider>();

    final authProvider =
        context.read<AuthProvider>();

    final chat = chatProvider.chats.first;

    chatProvider.sendMessage(

      chatId: chat.id,

      senderId:
          authProvider.user?.id ?? 'me',

      text: _messageController.text,
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    final chatProvider =
        context.watch<ChatProvider>();

    final authProvider =
        context.watch<AuthProvider>();

    if (chatProvider.chats.isEmpty) {

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final chat = chatProvider.chats.first;

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          icon: const Icon(Icons.arrow_back),

          onPressed: () => context.go('/livros'),
        ),

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(widget.book.ownerName ?? 'Usuário'),

            Text(

              widget.book.title,

              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),

        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        elevation: 1,
      ),

      body: Column(

        children: [

          // LISTA DE MENSAGENS
          Expanded(

            child: ListView.builder(

              padding: const EdgeInsets.all(16),

              itemCount: chat.messages.length,

              itemBuilder: (context, index) {

                final message =
                    chat.messages[index];

                final isMe =
                    message.senderId ==
                    authProvider.user?.id;

                return Align(

                  alignment:
                      isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,

                  child: Container(

                    margin:
                        const EdgeInsets.symmetric(
                      vertical: 5,
                    ),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(

                      color:
                          isMe
                              ? const Color(
                                  0xFF2C3A66,
                                )
                              : const Color(
                                  0xFFF3F4F8,
                                ),

                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: Text(

                      message.text,

                      style: TextStyle(

                        color:
                            isMe
                                ? Colors.white
                                : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // INPUT
          Padding(

            padding: const EdgeInsets.all(12),

            child: Row(

              children: [

                Expanded(

                  child: TextField(

                    controller:
                        _messageController,

                    decoration: InputDecoration(

                      hintText:
                          'Digite sua mensagem...',

                      border: OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                          25,
                        ),
                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                CircleAvatar(

                  backgroundColor:
                      const Color(0xFF2C3A66),

                  child: IconButton(

                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),

                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}