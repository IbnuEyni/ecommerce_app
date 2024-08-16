import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:equatable/equatable.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final DeleteProduct deleteProduct;
  final InputConverter inputConverter;
  DeleteBloc(this.deleteProduct, this.inputConverter) : super(DeleteInitial()) {
    on<DeleteProductEvent>((event, emit) async {
      // Convert the string ID to an unsigned integer
      final inputEither = inputConverter.stringToUnsignedInteger(event.id);

      inputEither.fold(
        (failure) {
          emit(DeleteProductLoading());
          emit(DeleteProductError(message: 'Invalid ID'));
        },
        (id) async {
          emit(DeleteProductLoading());
          final deleteEither = await deleteProduct(DeleteParams(id: id));

          emit(deleteEither.fold(
            (failure) =>
                DeleteProductError(message: _mapFailureToMessage(failure)),
            (_) => DeleteProductLoaded(),
          ));
        },
      );
    });
  }
}

// Map failure to appropriate error message
String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Failure';
    case InvalidInputFailure:
      return 'Invalid Input';
    default:
      return 'Unexpected Error';
  }
}
