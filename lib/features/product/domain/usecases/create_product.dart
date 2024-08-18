import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProduct implements Usecase<Product, CreateParams> {
  final ProductRepository repository;

  CreateProduct({required this.repository});
  Future<Either<Failure, Product>> call(CreateParams params) async {
    return await repository.createProduct(params.id, params.name,
        params.description, params.imageUrl, params.price);
  }
}

class CreateParams extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const CreateParams({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl, price];
}
