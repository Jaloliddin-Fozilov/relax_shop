import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';

import './styles/relax_app_style.dart';

import './screens/home_screen.dart';

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
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          HomeScreen.routName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
