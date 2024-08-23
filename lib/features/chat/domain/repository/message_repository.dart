import 'package:ecommerce_app/features/chat/domain/entities/message.dart';

abstract class MessageRepository {
  Future<void> sendMessage(Message message);
  Future<List<Message>> getMessages(String chatId);
  Stream<Message> listenForMessages(String chatId);
}
