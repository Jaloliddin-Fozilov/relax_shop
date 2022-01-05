import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

import '../widgets/cart_list_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Savatcha",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => cart.removeItems(),
              child: const Text(
                "Tozalash",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Text(
                "Sizning buyurtmalaringiz",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, index) {
                  final cartItem = cart.items.values.toList()[index];
                  return CartListItem(
                    productId: cart.items.keys.toList()[index],
                    imageUrl: cartItem.imageUrl,
                    title: cartItem.title,
                    price: cartItem.price,
                    quantity: cartItem.quantity,
                    backgroundcolor: cartItem.backgroundcolor,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: BottomAppBar(
          child: Container(
            height: 110,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Umumiy summa:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${cart.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addToOrders(
                      cart.items.values.toList(),
                      cart.totalPrice,
                    );
                    cart.removeItems();
                  },
                  child: Text(
                    "Xarid qilish \$${cart.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
