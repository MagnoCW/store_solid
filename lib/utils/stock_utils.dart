import 'package:solid/models/product.dart';
import 'package:solid/models/stock_item.dart';

StockItem? createStockProduct(
    String productName, String productPrice, String productQuantity) {
  if (productName.isNotEmpty &&
      productPrice.isNotEmpty &&
      productQuantity.isNotEmpty) {
    try {
      double price = double.parse(productPrice);
      int quantity = int.parse(productQuantity);

      return StockItem(
        product: Product(
          name: productName,
          price: price,
        ),
        quantityInStock: quantity,
      );
    } catch (e) {
      return null;
    }
  }

  return null;
}
