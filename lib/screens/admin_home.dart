import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/cart/cart_bloc.dart';
import 'package:solid/blocs/cart/cart_state.dart';
import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/shopping_cart.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final ShoppingCart _shoppingCart = ShoppingCart();
  late final CartBloc _cartBloc;
  final ProductsInStock _productsInStock = ProductsInStock();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = CartBloc(_shoppingCart, _productsInStock);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cartBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Loja de Produtos"),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: _productsInStock.stockItem.length,
              itemBuilder: (context, index) {
                final stockItem = _productsInStock.stockItem[index];
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
                            decoration: InputDecoration(
                              hintText: "Nome do Produto",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              filled: true,
                              fillColor:
                                  Colors.grey[200], // Cor de fundo da caixinha
                            ),
                          ),
                          const SizedBox(height: 10), // Espaço entre os campos
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
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
                              onPressed: () => Navigator.of(context).pop(),
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
