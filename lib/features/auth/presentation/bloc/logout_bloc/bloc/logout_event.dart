part of 'logout_bloc.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends LogoutEvent {
  final String token;

  const LogoutRequested({required this.token});

  @override
  List<Object> get props => [token];
}
