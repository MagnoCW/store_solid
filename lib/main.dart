import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/bloc/cart_bloc.dart';
import 'package:solid/screens/product_screen.dart';
import 'package:solid/shopping_cart.dart';

void main() {
  final ShoppingCart shoppingCart = ShoppingCart();
  runApp(
    BlocProvider(
      create: (context) => CartBloc(shoppingCart),
      child: const MyApp(),
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
      home: const ProductScreen(),
    );
  }
}
