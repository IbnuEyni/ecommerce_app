part of 'list_products_bloc.dart';

sealed class ListProductsEvent extends Equatable {
  const ListProductsEvent();

  @override
  List<Object> get props => [];
}

class ListEvent extends ListProductsEvent {
  @override
  List<Object> get props => [];
}
