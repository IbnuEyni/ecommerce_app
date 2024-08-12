import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'detail_product.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProduct implements Usecase<Unit, DeleteParams> {
  final ProductRepository repository;

  DeleteProduct({required this.repository});
  Future<Either<Failure, Unit>> call(DeleteParams params) async {
    return await repository.deleteProduct(params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;

  DeleteParams({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
