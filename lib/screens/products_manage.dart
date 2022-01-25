import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import '/screens/edit_product_screen.dart';

import '../providers/products.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({Key? key}) : super(key: key);

  static const routName = "/manage-products";

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mahsulotlarni boshqarish"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProuductScreen.routName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: productProvider.list.length,
        itemBuilder: (ctx, index) {
          final product = productProvider.list[index];
          return ChangeNotifierProvider.value(
            value: product,
            child: const UserProductItem(),
          );
        },
      ),
    );
  }
}
