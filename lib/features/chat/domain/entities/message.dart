class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final String senderId;
  final String receiverId;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
    required this.receiverId,
  });
}
