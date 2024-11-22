import 'package:solid/models/stock_item.dart';

abstract class StockEvent {}

class AddStockItemEvent extends StockEvent {
  final StockItem stockItem;

  AddStockItemEvent(this.stockItem);
}

class RemoveStockItemEvent extends StockEvent {
  final StockItem stockItem;

  RemoveStockItemEvent(this.stockItem);
}
