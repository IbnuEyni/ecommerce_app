import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/local_data_sources.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/remote_data_resources.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import '../../../product/data/repositories/product_repository_impl_test.mocks.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tName = 'John Doe';
  final tEmail = 'test@test.com';
  final tPassword = 'password123';
  final tAuthUserModel = AuthUserModel(
    id: '123',
    email: tEmail,
    name: tName,
    token: 'abc123',
  );
  final tAuthUser = AuthUser(
    id: '123',
    email: tEmail,
    name: tName,
    token: 'abc123',
  );

  group('signUp', () {
    test('should cache auth token and return AuthUser on successful sign up',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.signUp(
        name: tName,
        email: tEmail,
        password: tPassword,
      )).thenAnswer((_) async => tAuthUserModel);

      // Act
      final result = await repository.signUp(
        name: tName,
        email: tEmail,
        password: tPassword,
      );

      // Assert
      verify(mockLocalDataSource.cacheAuthToken(tAuthUser.token));
      expect(result, Right(tAuthUser));
    });

    test('should return ServerFailure when the response code is not 201',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.signUp(
        name: tName,
        email: tEmail,
        password: tPassword,
      )).thenThrow(ServerException());

      // Act
      final result = await repository.signUp(
        name: tName,
        email: tEmail,
        password: tPassword,
      );

      // Assert
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, Left(ServerFailure()));
    });
  });

  group('login', () {
    test('should cache auth token and return AuthUser on successful login',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(
        email: tEmail,
        password: tPassword,
      )).thenAnswer((_) async => tAuthUserModel);

      // Act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      verify(mockLocalDataSource.cacheAuthToken(tAuthUser.token));
      expect(result, Right(tAuthUser));
    });

    test('should return ServerFailure when the response code is not 200',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(
        email: tEmail,
        password: tPassword,
      )).thenThrow(ServerException());

      // Act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, Left(ServerFailure()));
    });
  });

  group('logout', () {
    test('should return Unit when the response code is 200 (OK)', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.logout(token: anyNamed('token')))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.logout('abc123');

      // Assert
      expect(result, const Right(unit));
    });

    test('should return ServerFailure when the response code is not 200',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.logout(token: anyNamed('token')))
          .thenThrow(ServerException());

      // Act
      final result = await repository.logout('abc123');

      // Assert
      expect(result, Left(ServerFailure()));
    });
  });
}
