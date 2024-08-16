part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class Loading extends DetailState {}

final class Loaded extends DetailState {
  final Product product;

  Loaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class Error extends DetailState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
