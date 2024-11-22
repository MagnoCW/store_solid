import 'package:solid/models/products_in_stock.dart';

abstract class StockState {
  final ProductsInStock productsInStock;

  StockState({required this.productsInStock});
}

class StockInitialState extends StockState {
  StockInitialState() : super(productsInStock: ProductsInStock());
}

class StockUpdatedState extends StockState {
  StockUpdatedState({required super.productsInStock});
}
