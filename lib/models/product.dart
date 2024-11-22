class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
  double get finalPrice => price;
}
