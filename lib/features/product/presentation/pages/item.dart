class Product {
  String imageUrl;
  String name;
  double price;
  String description;
  double rating;
  String category;
  int id;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.rating,
    required this.id,
    required this.category,
  });
}

final List<Product> items = [
  Product(
    imageUrl: 'images/shoes3.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: 1,
    category: 'shoes',
  ),
  Product(
    imageUrl: 'images/shoes2.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: 2,
    category: 'shoes',
  ),
  Product(
    imageUrl: 'images/shoes.jpeg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: 3,
    category: 'shoes',
  ),
  Product(
    imageUrl: 'images/shoes4.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: 4,
    category: 'shoes',
  ),
  Product(
    imageUrl: 'images/shoes5.jpeg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: 5,
    category: 'shoes',
  ),
];
