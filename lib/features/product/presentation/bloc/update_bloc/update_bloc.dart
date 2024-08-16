import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
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
      final inputEither = inputConverter.stringToUnsignedInteger(event.id);

      await inputEither.fold((failure) {
        emit(UpdateProductError(message: 'Invalid ID'));
      }, (id) async {
        //Emit a loading while the update is in progress
        emit(UpdateProductLoading());
        // Execute the update product usecase
        final updateEither = await updateProduct(UpdateParams(
          id: id,
          name: event.name,
          description: event.description,
          imageUrl: event.imageUrl,
          price: int.parse(event.price),
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
