part of 'delete_bloc.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();

  @override
  List<Object> get props => [];
}

final class DeleteInitial extends DeleteState {}

final class DeleteProductLoading extends DeleteState {}

final class DeleteProductLoaded extends DeleteState {}

final class DeleteProductError extends DeleteState {
  final String message;

  const DeleteProductError({required this.message});

  @override
  List<Object> get props => [message];
}
