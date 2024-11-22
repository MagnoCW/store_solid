import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/shopping_cart.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final ShoppingCart shoppingCart;
  final ProductsInStock productsInStock;

  CartUpdatedState(this.shoppingCart, this.productsInStock);
}
