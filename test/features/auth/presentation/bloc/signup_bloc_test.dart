import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_bloc_test.mocks.dart';

@GenerateMocks([SignUpUseCase])
void main() {
  late SignupBloc signUpBloc;
  late MockSignUpUseCase mockSignUpUseCase;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    signUpBloc = SignupBloc(signUpUseCase: mockSignUpUseCase);
  });

  group('SignUpBloc', () {
    const tAuthUser = AuthUser(
        id: '123', name: 'John Doe', email: 'test@test.com', token: 'abc123');
    const tName = 'amir ahme';
    const tEmail = 'test@test.com';
    const tPassword = 'password123';
    test('initial state should be SignUpInitial', () {
      expect(signUpBloc.state, SignupInitial());
    });

    blocTest<SignupBloc, SignupState>(
      'emits [SignUpLoading, SignUpSuccess] when SignUpRequested is added and use case succeeds',
      build: () {
        when(mockSignUpUseCase(name: tName, email: tEmail, password: tPassword))
            .thenAnswer((_) async => const Right(tAuthUser));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(
          SignUpRequested(name: tName, email: tEmail, password: tPassword)),
      expect: () => [
        SignupLoading(),
        const SignupLoaded(user: tAuthUser),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignUpLoading, SignUpFailure] when SignUpRequested is added and use case fails',
      build: () {
        when(mockSignUpUseCase(name: tName, email: tEmail, password: tPassword))
            .thenAnswer((_) async => Left(ServerFailure()));
        return signUpBloc;
      },
      act: (bloc) => bloc.add(
          SignUpRequested(name: tName, email: tEmail, password: tPassword)),
      expect: () => [
        SignupLoading(),
        const SignupError(message: 'Sign up failed'),
      ],
    );
  });
}
