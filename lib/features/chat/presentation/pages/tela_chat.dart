import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  const ChatScreen({super.key, this.userName = "Usuário"});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"text": "Olá! Tenho interesse no seu livro.", "isMe": false},
    {"text": "Oi! Qual livro você tem para trocar?", "isMe": true},
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _messageController.text,
          "isMe": true,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/livros'),
        ),
        title: Text(widget.userName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Área das Mensagens
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? const Color(0xFF2C3A66) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(color: msg['isMe'] ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          // Campo de Entrada (Onde o seu formulário se transforma em chat)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF2C3A66),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
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