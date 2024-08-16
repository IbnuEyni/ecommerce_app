part of 'delete_bloc.dart';

sealed class DeleteEvent extends Equatable {
  const DeleteEvent();

  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends DeleteEvent {
  final String id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}
