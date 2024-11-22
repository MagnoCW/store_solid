import 'package:solid/models/cart_item.dart';
import 'package:solid/models/stock_item.dart';

abstract class CartEvent {}

class AddCartItemEvent extends CartEvent {
  final CartItem cartItem;
  final StockItem stockItem;

  AddCartItemEvent(this.cartItem, this.stockItem);
}

class RemoveCartItemEvent extends CartEvent {
  final CartItem cartItem;

  RemoveCartItemEvent(this.cartItem);
}
