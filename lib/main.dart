import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/blocs/cart/cart_bloc.dart';
import 'package:solid/blocs/stock/stock_bloc.dart';
import 'package:solid/models/products_in_stock.dart';
import 'package:solid/models/shopping_cart.dart';
import 'package:solid/screens/admin_home.dart';

void main() {
  final ShoppingCart shoppingCart = ShoppingCart();
  final ProductsInStock productsInStock = ProductsInStock();
  final StockBloc stockBloc = StockBloc(productsInStock);

  runApp(
    BlocProvider(
      create: (context) => CartBloc(shoppingCart, productsInStock),
      child: BlocProvider(
        create: (context) => stockBloc,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AdminHome(),
    );
  }
}
