import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/detail_product.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final Usecase detailProduct;
  final InputConverter inputConverter;

  DetailBloc({
    required this.detailProduct,
    required this.inputConverter,
  }) : super(DetailInitial()) {
    on<DetailProductEvent>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInteger(event.id);

      await inputEither.fold(
        (failure) async {
          emit(Error(message: 'INVALID_INPUT_FAILURE_MESSAGE'));
        },
        (id) async {
          emit(Loading());
          final failureOrProduct = await detailProduct(DetailParams(id: id));
          emit(failureOrProduct.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (product) => Loaded(product: product),
          ));
        },
      );
    });
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
