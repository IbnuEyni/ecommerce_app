import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout(
    String token,
  );
}
