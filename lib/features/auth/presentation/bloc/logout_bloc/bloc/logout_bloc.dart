import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase logoutUseCase;
  LogoutBloc(this.logoutUseCase) : super(LogoutInitial()) {
    on<LogoutRequested>((event, emit) async {
      emit(LogoutLoading());
      final result = await logoutUseCase();

      result.fold((failure) => emit(LogoutError(message: 'Logout Failed')),
          (_) => emit(LogoutLoaded()));
    });
  }
}
