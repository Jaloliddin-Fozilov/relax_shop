import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relax_shop/screens/product_detail_screen.dart';

import './providers/products.dart';

import './styles/relax_app_style.dart';

import './screens/home_screen.dart';

import './models/product.dart';

void main() {
  runApp(MyApp());
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
