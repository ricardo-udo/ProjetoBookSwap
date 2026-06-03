import 'package:flutter/material.dart';

import '../features/chat/data/models/chat.dart';
import '../features/chat/data/models/message.dart';

class ChatProvider extends ChangeNotifier {

  final List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  // CRIAR CHAT
  void createChat({

    required String bookId,

    required String user1Id,

    required String user2Id,
  }) {

    final newChat = Chat(

      id: DateTime.now().toString(),

      bookId: bookId,

      user1Id: user1Id,

      user2Id: user2Id,

      messages: [],
    );

    _chats.add(newChat);

    notifyListeners();
  }

  // ENVIAR MENSAGEM
  void sendMessage({

    required String chatId,

    required String senderId,

    required String text,
  }) {

    final chatIndex = _chats.indexWhere(
      (chat) => chat.id == chatId,
    );

    if (chatIndex == -1) return;

    final message = Message(

      id: DateTime.now().toString(),

      senderId: senderId,

      text: text,

      createdAt: DateTime.now(),
    );

    _chats[chatIndex].messages.add(message);

    notifyListeners();
  }

  // PEGAR CHAT PELO ID
  Chat? getChatById(String chatId) {

    try {

      return _chats.firstWhere(
        (chat) => chat.id == chatId,
      );

    } catch (e) {

      return null;
    }
  }
}