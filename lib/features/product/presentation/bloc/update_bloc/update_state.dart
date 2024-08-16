part of 'update_bloc.dart';

sealed class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

final class UpdateInitial extends UpdateState {}

final class UpdateProductLoading extends UpdateState {}

final class UpdateProductLoaded extends UpdateState {
  final Product product;

  UpdateProductLoaded({required this.product});
  @override
  List<Object> get props => [product];
}

final class UpdateProductError extends UpdateState {
  final String message;

  UpdateProductError({required this.message});
  @override
  List<Object> get props => [message];
}
