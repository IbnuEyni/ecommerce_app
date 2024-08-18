import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
        );

  /// Factory constructor to create a [ProductModel] from a JSON map.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
    );
  }

  /// Converts the [ProductModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "price": price
    };
  }

  // /// Converts a list of JSON maps to a list of [ProductModel] instances.
  // static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
  //   return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  // }

  // /// Converts a list of [ProductModel] instances to a list of JSON maps.
  // static List<Map<String, dynamic>> toJsonList(List<ProductModel> products) {
  //   return products.map((product) => product.toJson()).toList();
  // }
}
