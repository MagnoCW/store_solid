import 'package:solid/models/cart_item.dart';
import 'package:solid/models/cart_status.dart';
import 'package:solid/models/order_notifier.dart';
import 'package:solid/models/stock_item.dart';

class ShoppingCart {
  List<CartItem> cartItems = [];
  CartStatus status = CartStatus.open;
  double totalValueOfItems = 0;
  int totalItems = 0;

  void addItemToCart(CartItem cartItem, StockItem stockItem) {
    bool itemExists = false;

    if (stockItem.checkStock()) {
      for (var existItem in cartItems) {
        if (existItem.product.name == cartItem.product.name) {
          existItem.addItemToCart();
          totalValueOfItems += cartItem.product.price;
          totalItems += 1;
          itemExists = true;
          break;
        }
      }
      if (!itemExists) {
        cartItem.addItemToCart();
        cartItems.add(cartItem);
        totalValueOfItems += cartItem.product.price;
        totalItems += 1;
      }
    } else {
      print("Insufficient amount in stock.");
    }
  }

  void removeItemFromCart(CartItem cartItem) {
    if (cartItem.quantityInCart > 0) {
      cartItem.removeItemFromCart();
      totalValueOfItems -= cartItem.product.price;
      totalItems -= 1;
    } else {
      print("Amount in cart is insufficient to remove.");
    }
  }

  double getTotalValue() => totalValueOfItems;

  CartStatus getStatus() => status;

  bool cartValidate() => cartItems.isNotEmpty;

  void confirmOrder(OrderNotifier notifier) {
    if (cartValidate()) {
      status = CartStatus.confirmed;
      notifier.sendConfirmation();
    } else {
      throw Exception('Cannot confirm an empty cart.');
    }
  }
}
