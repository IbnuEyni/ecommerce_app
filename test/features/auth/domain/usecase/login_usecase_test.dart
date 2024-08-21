import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  final tEmail = 'test@test.com';
  final tPassword = 'password123';
  final tAuthUser = AuthUser(
    id: '123',
    email: tEmail,
    name: 'John Doe',
    token: 'abc123',
  );

  test('should return AuthUser when login is successful', () async {
    // Arrange
    when(mockAuthRepository.login(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Right(tAuthUser));

    // Act
    final result = await useCase(
      email: tEmail,
      password: tPassword,
    );

    // Assert
    expect(result, Right(tAuthUser));
    verify(mockAuthRepository.login(
      email: tEmail,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when login fails', () async {
    // Arrange
    final tFailure = ServerFailure();
    when(mockAuthRepository.login(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase(
      email: tEmail,
      password: tPassword,
    );

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.login(
      email: tEmail,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
