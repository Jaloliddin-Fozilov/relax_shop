import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(order.id),
      subtitle: Text(
        DateFormat('dd.MM.yyyy').format(order.date),
      ),
      children: order.products.map(
        (product) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: product.imageUrl.startsWith("assets/")
                  ? AssetImage(
                      product.imageUrl,
                    )
                  : NetworkImage(
                      product.imageUrl,
                    ) as ImageProvider,
            ),
            title: Text(product.title),
            subtitle: Text("${product.price}"),
            trailing: Text("x${product.quantity}"),
          );
        },
      ).toList(),
    );
  }
}
