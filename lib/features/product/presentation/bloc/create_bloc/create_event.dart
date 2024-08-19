part of 'create_bloc.dart';

sealed class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class CreateProductEvent extends CreateEvent {
  final String name;
  final String description;
  final String imageUrl;
  final String price;

  CreateProductEvent(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.price});
  @override
  List<Object> get props => [name, description, imageUrl, price];
}
