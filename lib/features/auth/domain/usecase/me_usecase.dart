import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';

class MeUsecase {
  final AuthRepository repository;

  MeUsecase(this.repository);

  Future<Either<Failure, AuthUser>> call({required String token}) {
    return repository.me(token: token);
  }
}
