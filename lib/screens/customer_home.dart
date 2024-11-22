import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/cart/cart_bloc.dart';
import 'package:solid/blocs/cart/cart_event.dart';
import 'package:solid/blocs/cart/cart_state.dart';
import 'package:solid/models/cart_item.dart';
import 'package:solid/models/product.dart';
import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/shopping_cart.dart';
import 'package:solid/models/stock_item.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final ShoppingCart _shoppingCart = ShoppingCart();
  late final CartBloc _cartBloc;
  final ProductsInStock _productsInStock = ProductsInStock();

  void _addItemToCart(Product product, StockItem stockItem) {
    context.read<CartBloc>().add(AddCartItemEvent(
          CartItem(product: product),
          stockItem,
        ));
  }

  @override
  void initState() {
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
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartUpdatedState) {
                        int itemCount = state.shoppingCart.totalItems;
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
                        _shoppingCart.cartItems.isEmpty
                            ? const Text("Carrinho vazio.")
                            : Column(
                                children:
                                    _shoppingCart.cartItems.map<Widget>((item) {
                                  return Text(
                                    "${item.product.name} - Quantidade: ${item.quantityInCart} - Preço: \$${item.product.price * item.quantityInCart}",
                                  );
                                }).toList(),
                              ),
                        const SizedBox(height: 10),
                        Text(
                          "Total: \$${_shoppingCart.getTotalValue()}",
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
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      _addItemToCart(stockItem.product, stockItem);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
