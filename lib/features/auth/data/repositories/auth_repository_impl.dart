import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/local_data_sources.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/remote_data_resources.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthUser>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    return await _getResponse(() {
      return remoteDataSource.signUp(
          name: name, email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, AuthUser>> login(
      {required String email, required String password}) async {
    return await _getResponse(() {
      return remoteDataSource.login(email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, Unit>> logout(String token) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout(token: 'token');
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, AuthUser>> _getResponse(
      Future<AuthUserModel> Function() getMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuthUser = await getMethod();
        // Convert the AuthUserModel to AuthUser
        final authUser = convertAuthUserModelToAuthUser(remoteAuthUser);

        // Cache the auth token locally
        await localDataSource.cacheAuthToken(authUser.token);
        return Right(authUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

AuthUserModel convertAuthUserToAuthUserModel(AuthUser authUser) {
  return AuthUserModel(
    id: authUser.id,
    name: authUser.name,
    email: authUser.email,
    token: authUser.token,
  );
}

AuthUser convertAuthUserModelToAuthUser(AuthUserModel authUserModel) {
  return AuthUser(
    id: authUserModel.id,
    name: authUserModel.name,
    email: authUserModel.email,
    token: authUserModel.token,
  );
}
