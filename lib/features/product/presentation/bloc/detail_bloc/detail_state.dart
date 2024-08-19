part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final Product product;

  DetailLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});

  @override
  List<Object> get props => [message];
}
