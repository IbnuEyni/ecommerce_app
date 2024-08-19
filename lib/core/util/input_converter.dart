import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputConverter {
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final ans = double.parse(str);
      if (ans < 0) throw const FormatException();
      return Right(ans);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
