import 'package:dartz/dartz.dart';
import '../error/failure.dart';

class InputConverter {
  InputConverter(String id);

  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final ans = int.parse(str);
      if (ans < 0) throw const FormatException();
      return Right(ans);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
