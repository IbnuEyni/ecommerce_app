import 'package:ecommerce_app/features/chat/domain/repository/message_repository.dart';
import '../entities/message.dart';

class ReceiveMessagesUseCase {
  final MessageRepository repository;

  ReceiveMessagesUseCase(this.repository);

  Future<List<Message>> call(String chatId) async {
    return await repository.getMessages(chatId);
  }
}
