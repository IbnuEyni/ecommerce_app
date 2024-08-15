import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class ListProducts implements Usecase<List<Product>, NoParams> {
  final ProductRepository repository;

  ListProducts({required this.repository});
  @override
  Future<Either<Failure, List<Product>>> call(params) async {
    return await repository.listProducts();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
