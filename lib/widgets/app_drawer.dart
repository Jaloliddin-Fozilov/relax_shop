import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text("Menu"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Bosh Sahifa"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomeScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text("Buyurtmalar"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Mahsulotlarni boshqarish"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routName),
          ),
        ],
      ),
    );
  }
}
