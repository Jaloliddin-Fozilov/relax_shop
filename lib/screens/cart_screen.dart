import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Sizning savatchangiz"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              const Text(
                "Sizning buyurtmalaringiz",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(),
              ),
            ],
          ),
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
                  onPressed: () {},
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
