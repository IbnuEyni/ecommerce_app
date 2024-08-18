import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/detail_product.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final Usecase detailProduct;

  DetailBloc({
    required this.detailProduct,
  }) : super(DetailInitial()) {
    on<DetailProductEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrProduct =
            await detailProduct(DetailParams(id: event.id));
        emit(failureOrProduct.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (product) => Loaded(product: product),
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
