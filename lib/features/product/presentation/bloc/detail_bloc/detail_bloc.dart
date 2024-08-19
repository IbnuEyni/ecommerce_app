import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/detail_product.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailProduct detailProduct;

  DetailBloc({
    required this.detailProduct,
  }) : super(DetailInitial()) {
    on<DetailProductEvent>(
      (event, emit) async {
        emit(DetailLoading());
        final failureOrProduct =
            await detailProduct(DetailParams(id: event.id));
        emit(failureOrProduct.fold(
          (failure) => DetailError(message: _mapFailureToMessage(failure)),
          (product) => DetailLoaded(product: product),
        ));
      },
    );
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      default:
        return 'Unexpected Error';
    }
  }
}
