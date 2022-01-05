import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final Color backgroundcolor;
  const CartListItem({
    Key? key,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.backgroundcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: imageUrl.startsWith("assets/")
              ? Image.asset(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                )
              : Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                ),
        ),
        title: Text(title),
        subtitle: Text('\$${(price * quantity).toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => cart.removeSingleItem(productId),
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100],
              ),
              child: Text(
                "$quantity",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () => cart.addtoCart(
                productId,
                title,
                imageUrl,
                price,
                backgroundcolor,
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
