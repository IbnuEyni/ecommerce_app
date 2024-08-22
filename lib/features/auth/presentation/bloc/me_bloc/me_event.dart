part of 'me_bloc.dart';

sealed class MeEvent extends Equatable {
  const MeEvent();

  @override
  List<Object> get props => [];
}

class MeRequested extends MeEvent {
  final String token;

  const MeRequested({required this.token});

  @override
  List<Object> get props => [token];
}
