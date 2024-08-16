part of 'create_bloc.dart';

sealed class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object> get props => [];
}

final class CreateProductInitial extends CreateState {}

final class CreateProductLoading extends CreateState {}

final class CreateProductLoaded extends CreateState {
  final Product newProduct;

  CreateProductLoaded({required this.newProduct});
  @override
  List<Object> get props => [newProduct];
}

final class CreateProductError extends CreateState {
  final String message;

  CreateProductError({required this.message});
  @override
  List<Object> get props => [message];
}
