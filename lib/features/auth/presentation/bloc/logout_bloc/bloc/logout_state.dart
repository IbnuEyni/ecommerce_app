part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutLoaded extends LogoutState {}

final class LogoutError extends LogoutState {
  final String message;

  const LogoutError({required this.message});

  @override
  List<Object> get props => [message];
}
