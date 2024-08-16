part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailProductEvent extends DetailEvent {
  final String id;

  DetailProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}
