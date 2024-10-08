import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProduct implements Usecase<Unit, DeleteParams> {
  final ProductRepository repository;

  DeleteProduct({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(DeleteParams params) async {
    return await repository.deleteProduct(params.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
