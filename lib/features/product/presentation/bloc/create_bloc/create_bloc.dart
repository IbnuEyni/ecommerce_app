import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:equatable/equatable.dart';

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
      final inputEither = inputConverter.stringToUnsignedInteger(event.id);

      await inputEither.fold((failure) {
        emit(CreateProductError(message: 'Invalid ID'));
      }, (id) async {
        //Emit a loading while the create is in progress
        emit(CreateProductLoading());
        // Execute the create product usecase
        final createEither = await createProduct(CreateParams(
          id: id,
          name: event.name,
          description: event.description,
          imageUrl: event.imageUrl,
          price: int.parse(event.price),
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
