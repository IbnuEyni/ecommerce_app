import 'package:ecommerce_app/features/chat/domain/repository/message_repository.dart';

import '../entities/message.dart';

class SendMessage {
  final MessageRepository repository;

  SendMessage(this.repository);

  Future<void> call(Message message) async {
    return await repository.sendMessage(message);
  }
}
