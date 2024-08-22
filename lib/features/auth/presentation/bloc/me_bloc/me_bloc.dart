import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/me_usecase.dart';
import 'package:equatable/equatable.dart';

part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final MeUsecase meUsecase;
  MeBloc(this.meUsecase) : super(MeInitial()) {
    on<MeRequested>((event, emit) async {
      emit(MeLoading());
      final result = await meUsecase(token: event.token);

      result.fold((failure) => emit(const MeError(message: 'Me Failed')),
          (user) => emit(MeLoaded(user: user)));
    });
  }
}
