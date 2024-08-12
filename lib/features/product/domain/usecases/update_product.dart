import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct implements Usecase<Product, UpdateParams> {
  final ProductRepository repository;

  UpdateProduct({required this.repository});
  Future<Either<Failure, Product>> call(UpdateParams params) async {
    return await repository.updateProduct(params.id, params.name,
        params.description, params.imageUrl, params.price);
  }
}

class UpdateParams extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, description, imageUrl, price];
}
