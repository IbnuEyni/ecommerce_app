import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      final Either<Failure, AuthUser> result = await loginUseCase(
        email: event.email,
        password: event.password,
      );

      result.fold(
          (failure) => emit(LoginError(message: _mapFailureToMessage(failure))),
          (user) => emit(LoginLoaded(user: user)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return 'Login Failed';
  }
}
