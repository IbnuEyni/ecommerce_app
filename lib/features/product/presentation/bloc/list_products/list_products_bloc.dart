import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_all_products.dart';

part 'list_products_event.dart';
part 'list_products_state.dart';

class ListProductsBloc extends Bloc<ListProductsEvent, ListProductsState> {
  final ListProducts listProducts;
  ListProductsBloc(
    this.listProducts,
  ) : super(ListProductsInitial()) {
    print("Initialized successfully");
    on<ListEvent>((event, emit) async {
      emit(ListProductsLoading());
      final failureOrProducts = await listProducts(NoParams());
      emit(failureOrProducts.fold(
          (failure) =>
              ListProductsError(message: _mapFailureToMessage(failure)),
          (products) => ListProductsLoaded(products: products)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
