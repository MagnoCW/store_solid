import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/cart_event.dart';
import 'package:solid/bloc/cart_state.dart';
import 'package:solid/shopping_cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShoppingCart shoppingCart;

  CartBloc(this.shoppingCart) : super(CartInitialState());

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddProductEvent) {
      shoppingCart.addProduct(event.product);
      yield CartUpdatedState(shoppingCart);
    } else if (event is RemoveProductEvent) {
      shoppingCart.removeProduct(event.product);
      yield CartUpdatedState(shoppingCart);
    }
  }
}
