import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './favorites_screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/custom_cart.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routName = "/";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Relax shop",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Consumer<Cart>(
              builder: (ctx, cart, child) {
                return CustomCart(
                  icon: Icons.shopping_bag_outlined,
                  number: cart.itemsCount().toString(),
                );
              },
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sevimli buyumingizni tanlang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Ajoyiblik har bir buyumda mujassam",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(
                      child: Text('Barchasi'),
                    ),
                    Tab(
                      child: Text('Sevimli'),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ProductsGrid(),
                    FavoritesScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
