import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUpUseCase;

  SignupBloc({required this.signUpUseCase}) : super(SignupInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignupLoading());

      final result = await signUpUseCase(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(SignupError(message: _mapFailureToMessage(failure))),
        (user) => emit(SignupLoaded(user: user)),
      );
    });
  }

  String _mapFailureToMessage(failure) {
    return 'Sign up failed';
  }
}
