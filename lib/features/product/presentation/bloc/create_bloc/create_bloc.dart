import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/create_product.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final CreateProduct createProduct;
  final InputConverter inputConverter;
  CreateBloc(this.createProduct, this.inputConverter)
      : super(CreateProductInitial()) {
    on<CreateProductEvent>((event, emit) async {
      //Emit a loading while the create is in progress
      emit(CreateProductLoading());
      final inputEither = inputConverter.stringToUnsignedDouble(event.price);

      await inputEither.fold((failure) async {
        emit(CreateProductError(message: 'Invalid Price'));
      }, (price) async {
        //Emit a loading while the create is in progress
        emit(CreateProductLoading());
        // Execute the create product usecase
        final createEither = await createProduct(CreateParams(
          name: event.name,
          description: event.description,
          imageUrl: event.imageUrl,
          price: price,
        ));
        //Emit either success or error state based on the result
        emit(createEither.fold(
          (failure) =>
              CreateProductError(message: _mapFailureToMessage(failure)),
          (createdProduct) => CreateProductLoaded(newProduct: createdProduct),
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
