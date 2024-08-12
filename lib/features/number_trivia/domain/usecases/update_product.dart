import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct({required this.repository});
  Future<Either<Failure, Product>> call(UpdateParams params) async {
    return await repository.updateProduct(params.id, params.name,
        params.description, params.imageUrl, params.price);
  }
}

class UpdateParams {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;

  UpdateParams(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price});
}
