import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

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
