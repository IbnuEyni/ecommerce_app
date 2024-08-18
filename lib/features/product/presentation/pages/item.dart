class Item {
  String imageUrl;
  String name;
  double price;
  String description;
  double rating;
  String id;

  Item({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.rating,
    required this.id,
  });
}

final List<Item> items = [
  Item(
    imageUrl: 'images/shoes3.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: '1',
  ),
  Item(
    imageUrl: 'images/shoes2.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: '2',
  ),
  Item(
    imageUrl: 'images/shoes.jpeg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: '3',
  ),
  Item(
    imageUrl: 'images/shoes4.jpg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: '4',
  ),
  Item(
    imageUrl: 'images/shoes5.jpeg',
    name: 'Derby Leather Shoes',
    price: 120,
    description: 'Men’s shoe',
    rating: 4.0,
    id: '5',
  ),
];
