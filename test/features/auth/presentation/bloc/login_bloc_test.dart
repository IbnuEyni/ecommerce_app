import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(mockLoginUseCase);
  });

  group('LoginBloc', () {
    const tToken = 'abc123';
    const tEmail = 'test@test.com';
    const tPassword = 'password123';
    test('initial state should be SignUpInitial', () {
      expect(loginBloc.state, LoginInitial());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginLoaded] when LoginRequested is added and use case succeeds',
      build: () {
        when(mockLoginUseCase(email: tEmail, password: tPassword))
            .thenAnswer((_) async => const Right(tToken));
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginRequested(email: tEmail, password: tPassword)),
      expect: () => [
        LoginLoading(),
        const LoginLoaded(token: tToken),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] when LoginRequested is added and use case fails',
      build: () {
        when(mockLoginUseCase(email: tEmail, password: tPassword))
            .thenAnswer((_) async => Left(ServerFailure()));
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginRequested(email: tEmail, password: tPassword)),
      expect: () => [
        LoginLoading(),
        const LoginError(message: 'Login Failed'),
      ],
    );
  });
}
