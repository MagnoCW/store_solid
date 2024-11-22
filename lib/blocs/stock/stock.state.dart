import 'package:solid/models/products_in_stock.dart';

abstract class StockState {}

class StockInitialState extends StockState {}

class StockUpdatedState extends StockState {
  final ProductsInStock productsInStock;

  StockUpdatedState(this.productsInStock);
}
