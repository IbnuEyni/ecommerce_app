import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/chat/domain/repository/message_repository.dart';
import '../entities/message.dart';

class ListenForMessagesUseCase {
  final MessageRepository repository;

  ListenForMessagesUseCase(this.repository);

  Either<Failure, Stream<Message>> call(String chatId) {
    try {
      final stream = repository.listenForMessages(chatId);
      return Right(stream);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
