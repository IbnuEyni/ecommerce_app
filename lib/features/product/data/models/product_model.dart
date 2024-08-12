import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
  });
}
