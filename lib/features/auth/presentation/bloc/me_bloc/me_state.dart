part of 'me_bloc.dart';

sealed class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

final class MeInitial extends MeState {}

final class MeLoading extends MeState {}

final class MeLoaded extends MeState {
  final AuthUser user;

  const MeLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

final class MeError extends MeState {
  final String message;

  const MeError({required this.message});

  @override
  List<Object> get props => [message];
}
