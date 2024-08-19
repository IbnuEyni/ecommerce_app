import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/usecases/delete_product.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final DeleteProduct deleteProduct;
  DeleteBloc(this.deleteProduct) : super(DeleteInitial()) {
    on<DeleteProductEvent>(
      (event, emit) async {
        emit(DeleteProductLoading());
        final deleteEither = await deleteProduct(DeleteParams(id: event.id));

        emit(deleteEither.fold(
          (failure) =>
              DeleteProductError(message: _mapFailureToMessage(failure)),
          (_) => DeleteProductLoaded(),
        ));
      },
    );
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
