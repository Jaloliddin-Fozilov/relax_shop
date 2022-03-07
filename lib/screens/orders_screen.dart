import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  late Future _ordersFuture;
  Future _getOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).getOrdersFromFireBase();
  }

  @override
  void initState() {
    _ordersFuture = _getOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Buyurtmalar"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error == null) {
              return Consumer<Orders>(
                builder: (context, value, child) => orders.items.isEmpty
                    ? const Center(
                        child: Text("Hali mahsulotlarga buyurtma bermagansiz"),
                      )
                    : ListView.builder(
                        itemCount: orders.items.length,
                        itemBuilder: (ctx, index) {
                          final order = orders.items[index];
                          return OrderItem(
                            order: order,
                          );
                        },
                      ),
              );
            } else {
              return const Center(
                child: Text("Xatolik yuz berdi"),
              );
            }
          }
        },
      ),
    );
  }
}
