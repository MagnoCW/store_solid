import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/cart/cart_event.dart';
import 'package:solid/blocs/cart/cart_state.dart';
import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/shopping_cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShoppingCart shoppingCart;
  final ProductsInStock productsInStock;

  CartBloc(this.shoppingCart, this.productsInStock)
      : super(CartInitialState()) {
    on<AddCartItemEvent>((event, emit) {
      shoppingCart.addItemToCart(event.cartItem, event.stockItem);
      productsInStock.removeItemFromStock(event.stockItem);
      emit(CartUpdatedState(shoppingCart, productsInStock));
    });

    on<RemoveCartItemEvent>((event, emit) {
      shoppingCart.removeItemFromCart(event.cartItem);
      emit(CartUpdatedState(shoppingCart, productsInStock));
    });
  }
}
