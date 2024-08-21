import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'signup_usecase_test.mocks.dart';

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUseCase(mockAuthRepository);
  });
  final tToken = 'abc123';

  test('should return void when logout is successful', () async {
    // Arrange
    when(mockAuthRepository.logout(tToken))
        .thenAnswer((_) async => Right(null));

    // Act
    final result = await useCase(tToken);

    // Assert
    expect(result, Right(null));
    verify(mockAuthRepository.logout(tToken));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when logout fails', () async {
    // Arrange
    final tFailure = CacheFailure();
    when(mockAuthRepository.logout(tToken))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await useCase(tToken);

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.logout(tToken));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
