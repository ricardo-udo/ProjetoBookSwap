import 'message.dart';

class Chat {
  final String id;
  final String bookId;
  final String user1Id;
  final String user2Id;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.bookId,
    required this.user1Id,
    required this.user2Id,
    required this.messages,
  });
}
