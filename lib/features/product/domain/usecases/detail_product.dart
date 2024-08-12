import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DetailProduct implements Usecase<Product, DetailParams> {
  final ProductRepository repository;

  DetailProduct({required this.repository});
  Future<Either<Failure, Product>> call(DetailParams params) async {
    return await repository.detailProduct(params.id);
  }
}

class DetailParams extends Equatable {
  final int id;

  DetailParams({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
