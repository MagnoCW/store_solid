import 'package:solid/models/product.dart';

class CartItem {
  final Product product;
  int quantityInCart;

  CartItem({
    required this.product,
    this.quantityInCart = 0,
  });

  double get totalPrice => product.finalPrice * quantityInCart;

  void addItemToCart() {
    quantityInCart++;
    print(product.name);
    print(quantityInCart);
  }

  void removeItemFromCart() {
    quantityInCart--;
  }
}
