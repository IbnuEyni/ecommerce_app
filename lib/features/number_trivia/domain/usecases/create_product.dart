import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;

  CreateProduct({required this.repository});
  Future<Either<Failure, Product>> call(CreateParams params) async {
    return await repository.createProduct(params.id, params.name,
        params.description, params.imageUrl, params.price);
  }
}

class CreateParams {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;

  CreateParams(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price});
}
