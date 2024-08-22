import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthUser>> me({
    required String token,
  });
}
