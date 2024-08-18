import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/update_product.dart';
import '../detail_bloc/detail_bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpdateProduct updateProduct;
  final InputConverter inputConverter;
  UpdateBloc(this.updateProduct, this.inputConverter) : super(UpdateInitial()) {
    on<UpdateProductEvent>((event, emit) async {
      // Convert the string ID to an unsigned integer
      emit(UpdateProductLoading());
      final inputEither = inputConverter.stringToUnsignedDouble(event.price);

      await inputEither.fold((failure) {
        emit(UpdateProductError(message: 'Invalid Price'));
      }, (price) async {
        //Emit a loading while the update is in progress
        emit(UpdateProductLoading());
        // Execute the update product usecase
        final updateEither = await updateProduct(UpdateParams(
          id: event.id,
          name: event.name,
          description: event.description,
          imageUrl: event.imageUrl,
          price: price,
        ));

        //Emit either success or error state based on the result
        emit(updateEither.fold(
          (failure) =>
              UpdateProductError(message: _mapFailureToMessage(failure)),
          (updatedProduct) => UpdateProductLoaded(product: updatedProduct),
        ));
      });
    });
  }
}

// Map failure to appropriate error meassage
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
