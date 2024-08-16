part of 'update_bloc.dart';

sealed class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductEvent extends UpdateEvent {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String price;

  UpdateProductEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
      ];
}
