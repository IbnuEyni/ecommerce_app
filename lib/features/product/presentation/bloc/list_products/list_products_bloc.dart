import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:equatable/equatable.dart';

part 'list_products_event.dart';
part 'list_products_state.dart';

class ListProductsBloc extends Bloc<ListProductsEvent, ListProductsState> {
  final ListProducts listProducts;
  ListProductsBloc(
    this.listProducts,
  ) : super(ListProductsInitial()) {
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
