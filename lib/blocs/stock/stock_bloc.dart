import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/stock/stock.state.dart';
import 'package:solid/blocs/stock/stock_event.dart';
import 'package:solid/models/products_in_stock.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final ProductsInStock productsInStock;

  StockBloc(this.productsInStock) : super(StockInitialState()) {
    on<AddStockItemEvent>((event, emit) {
      productsInStock.addItemToStock();
      emit(StockUpdatedState(productsInStock: productsInStock));
    });

    on<RemoveStockItemEvent>((event, emit) {
      productsInStock.removeItemFromStock(event.stockItem);
      emit(StockUpdatedState(productsInStock: productsInStock));
    });
    on<AddStockProductEvent>((event, emit) {
      productsInStock.addProductToStock(event.stockItem);
      emit(StockUpdatedState(productsInStock: productsInStock));
    });
    on<DeleteStockProductEvent>((event, emit) {
      productsInStock.deleteProductFromStock();
      emit(StockUpdatedState(productsInStock: productsInStock));
    });
  }
}
