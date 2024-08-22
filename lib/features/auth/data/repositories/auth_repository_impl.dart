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
    return await _getAuthUser(() {
      return remoteDataSource.signUp(
          name: name, email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, String>> login(
      {required String email, required String password}) async {
    return await _getToken(() {
      return remoteDataSource.login(email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> me({required String token}) async {
    return await _getAuthUser(() {
      return remoteDataSource.me(token: token);
    });
  }

  Future<Either<Failure, AuthUser>> _getAuthUser(
      Future<AuthUserModel> Function() getMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final authUserModel = await getMethod();
        final authUser = convertAuthUserModelToAuthUser(authUserModel);
        return Right(authUserModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, String>> _getToken(
      Future<String> Function() getMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await getMethod();
        await localDataSource.cacheAuthToken(token);
        return Right(token);
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
  );
}

AuthUser convertAuthUserModelToAuthUser(AuthUserModel authUserModel) {
  return AuthUser(
    id: authUserModel.id,
    name: authUserModel.name,
    email: authUserModel.email,
  );
}
