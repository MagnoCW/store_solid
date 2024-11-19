import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/cart_bloc.dart';
import 'package:solid/bloc/cart_state.dart';
import 'package:solid/product.dart';
import 'package:solid/shopping_cart.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ShoppingCart shoppingCart = ShoppingCart();

  final List<Product> products = [
    Product(name: "Produto 1", price: 20.0, availableAmount: 2),
    Product(name: "Produto 2", price: 30.0, availableAmount: 2),
    Product(name: "Produto 3", price: 40.0, availableAmount: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja de Produtos"),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartUpdatedState) {
                      int itemCount = state.shoppingCart.totalProducts;
                      return Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$itemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Carrinho de Compras"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shoppingCart.products.isEmpty
                          ? const Text("Carrinho vazio.")
                          : Column(
                              children:
                                  shoppingCart.products.map<Widget>((item) {
                                return Text(
                                  "${item.name} - Quantidade: ${item.amountInCart} - Preço: \$${item.price * item.amountInCart}",
                                );
                              }).toList(),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        "Total: \$${shoppingCart.getTotalValue()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Fechar"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Preço: \$${product.price}"),
                Text("Estoque disponível: ${product.availableAmount}"),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                setState(() {
                  shoppingCart.addProduct(product);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
