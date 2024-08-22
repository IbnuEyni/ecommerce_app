import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/logout_bloc/bloc/logout_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_bloc_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  late LogoutBloc logoutBloc;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    logoutBloc = LogoutBloc(mockLogoutUseCase);
  });

  group('LogoutBloc', () {
    test('initial state should be LogoutInitial', () {
      expect(logoutBloc.state, LogoutInitial());
    });
    blocTest<LogoutBloc, LogoutState>(
      'emits [LogoutLoading, LogoutSuccess] when LogoutRequested is added and use case succeeds',
      build: () {
        when(mockLogoutUseCase()).thenAnswer((_) async => const Right(unit));
        return logoutBloc;
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expect: () => [
        LogoutLoading(),
        LogoutLoaded(),
      ],
    );
  });
}
