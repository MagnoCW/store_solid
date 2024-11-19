import 'package:solid/shopping_cart.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final ShoppingCart shoppingCart;

  CartUpdatedState(this.shoppingCart);
}
