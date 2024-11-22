import 'package:solid/models/product.dart';

class StockItem {
  final Product product;
  int quantityInStock;

  StockItem({
    required this.product,
    required this.quantityInStock,
  });

  void addItemToStock() {
    quantityInStock++;
  }

  void removeItemFromStock() {
    quantityInStock--;
  }

  bool checkStock() {
    return quantityInStock > 0;
  }
}
