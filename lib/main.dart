import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

import './styles/relax_app_style.dart';

import './screens/home_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import 'screens/products_manage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = RelaxAppStyle().theme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          HomeScreen.routName: (ctx) => const HomeScreen(),
          CartScreen.routName: (ctx) => const CartScreen(),
          OrdersScreen.routName: (ctx) => const OrdersScreen(),
          ManageProducts.routName: (ctx) => const ManageProducts(),
          EditProuductScreen.routName: (ctx) => const EditProuductScreen(),
        },
      ),
    );
  }
}
