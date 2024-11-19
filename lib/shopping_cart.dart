import 'package:solid/cart_status.dart';
import 'package:solid/order_notifier.dart';
import 'package:solid/product.dart';

class ShoppingCart {
  List<Product> products = [];
  CartStatus status = CartStatus.open;
  double totalValue = 0;
  int totalProducts = 0;

  void addProduct(Product product) {
    bool itemExists = false;

    if (product.availableAmount > 0) {
      for (var cartItem in products) {
        if (cartItem.name == product.name) {
          totalValue += product.price;
          product.addToCart();
          totalProducts += 1;
          itemExists = true;
          break;
        }
      }
      if (!itemExists) {
        product.addToCart();
        products.add(product);
        totalValue += product.price;
        totalProducts += 1;
      }
    } else {
      print("Insufficient amount in stock.");
    }
  }

  void removeProduct(Product product) {
    product.removeFromCart();
    totalValue -= product.price;
  }

  double getTotalValue() => totalValue;

  CartStatus getStatus() => status;

  bool cartValidate() => products.isNotEmpty;

  void confirmOrder(OrderNotifier notifier) {
    if (cartValidate()) {
      status = CartStatus.confirmed;
      notifier.sendConfirmation();
    } else {
      throw Exception('Cannot confirm an empty cart.');
    }
  }
}
