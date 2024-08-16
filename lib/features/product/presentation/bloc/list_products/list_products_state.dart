part of 'list_products_bloc.dart';

sealed class ListProductsState extends Equatable {
  const ListProductsState();

  @override
  List<Object> get props => [];
}

final class ListProductsInitial extends ListProductsState {}

class ListProductsLoading extends ListProductsState {}

class ListProductsLoaded extends ListProductsState {
  final List<Product> products;

  ListProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ListProductsError extends ListProductsState {
  final String message;

  ListProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
