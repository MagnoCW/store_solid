import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/stock/stock.state.dart';
import 'package:solid/blocs/stock/stock_bloc.dart';
import 'package:solid/blocs/stock/stock_event.dart';
import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/stock_item.dart';
import 'package:solid/utils/stock_utils.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late final StockBloc _stockBloc;
  final ProductsInStock _productsInStock = ProductsInStock();
  final TextEditingController _textEditingControllerProductName =
      TextEditingController();
  final TextEditingController _textEditingControllerProductPrice =
      TextEditingController();
  final TextEditingController _textEditingControllerProductQuantity =
      TextEditingController();

  void _addProduct(
      String productName, String productPrice, String productQuantity) {
    StockItem? product =
        createStockProduct(productName, productPrice, productQuantity);
    if (product != null) {
      setState(() {
        _productsInStock.addProductToStock(product);
      });
    }
  }

  void _addProductToStock(
      String productName, String productPrice, String productQuantity) {
    StockItem? product =
        createStockProduct(productName, productPrice, productQuantity);
    if (product != null) {
      context.read<StockBloc>().add(AddStockProductEvent(product));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockBloc = StockBloc(_productsInStock);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _stockBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Loja de Produtos"),
        ),
        body: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            final products = state.productsInStock.stockItem;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final stockItem = products[index];
                return ListTile(
                  title: Text(stockItem.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Preço: \$${stockItem.product.price}"),
                      Text("Estoque disponível: ${stockItem.quantityInStock}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Adicionar Produto ao Estoque"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _textEditingControllerProductName,
                            decoration: InputDecoration(
                              hintText: "Nome do Produto",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      _textEditingControllerProductPrice,
                                  decoration: InputDecoration(
                                    hintText: "Preço",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller:
                                      _textEditingControllerProductQuantity,
                                  decoration: InputDecoration(
                                    hintText: "Quantidade",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                StockItem? product = createStockProduct(
                                    _textEditingControllerProductName.text,
                                    _textEditingControllerProductPrice.text,
                                    _textEditingControllerProductQuantity.text);
                                if (product != null) {
                                  context
                                      .read<StockBloc>()
                                      .add(AddStockProductEvent(product));
                                }
                                Navigator.of(context).pop();
                              },
                              child: const Text("Adicionar"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Fechar"),
                            ),
                          ],
                        )
                      ],
                    ));
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
