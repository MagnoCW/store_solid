import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/stock/stock.state.dart';
import 'package:solid/blocs/stock/stock_event.dart';
import 'package:solid/models/products_in_stock.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final ProductsInStock productsInStock;

  StockBloc(this.productsInStock) : super(StockInitialState()) {
    on<AddStockItemEvent>((event, emit) {
      productsInStock.removeItemFromStock(event.stockItem);
      emit(StockUpdatedState(productsInStock));
    });

    on<RemoveStockItemEvent>((event, emit) {
      emit(StockUpdatedState(productsInStock));
    });
  }
}
