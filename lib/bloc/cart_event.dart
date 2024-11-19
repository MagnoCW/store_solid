import 'package:solid/product.dart';

abstract class CartEvent {}

class AddProductEvent extends CartEvent {
  final Product product;

  AddProductEvent(this.product);
}

class RemoveProductEvent extends CartEvent {
  final Product product;

  RemoveProductEvent(this.product);
}
