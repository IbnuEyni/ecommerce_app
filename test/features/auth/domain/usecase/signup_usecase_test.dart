import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignUpUseCase(mockAuthRepository);
  });

  final tName = 'John Doe';
  final tEmail = 'test@test.com';
  final tPassword = 'password123';
  final tAuthUser = AuthUser(
    id: '123',
    email: tEmail,
    name: tName,
  );

  test('should return AuthUser when sign-up is successful', () async {
    // Arrange
    when(mockAuthRepository.signUp(
      name: anyNamed('name'),
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Right(tAuthUser));

    // Act
    final result = await useCase(
      name: tName,
      email: tEmail,
      password: tPassword,
    );

    // Assert
    expect(result, Right(tAuthUser));
    verify(mockAuthRepository.signUp(
      name: tName,
      email: tEmail,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when sign-up fails', () async {
    // Arrange
    final tFailure = ServerFailure();
    when(mockAuthRepository.signUp(
      name: anyNamed('name'),
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase(
      name: tName,
      email: tEmail,
      password: tPassword,
    );

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.signUp(
      name: tName,
      email: tEmail,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
