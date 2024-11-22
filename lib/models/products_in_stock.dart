import 'package:solid/models/product.dart';
import 'package:solid/models/stock_item.dart';

class ProductsInStock {
  List<StockItem> stockItem = [
    StockItem(
        product: Product(
          name: "Produto 1",
          price: 20.0,
        ),
        quantityInStock: 5),
    StockItem(
        product: Product(
          name: "Produto 2",
          price: 30.0,
        ),
        quantityInStock: 5),
    StockItem(
        product: Product(
          name: "Produto 3",
          price: 40.0,
        ),
        quantityInStock: 5),
  ];

  void addItemToStock() {}

  void removeItemFromStock(StockItem stockItem) {
    if (stockItem.quantityInStock > 0) {
      stockItem.removeItemFromStock();
    } else {
      print("Insufficient amount in stock.");
    }
  }

  void addProductToStock(StockItem product) {
    stockItem.add(product);
    print('Product added: $product');
  }

  void deleteProductFromStock() {}
}
