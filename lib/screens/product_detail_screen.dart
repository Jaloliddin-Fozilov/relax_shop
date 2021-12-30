import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          color: product.color,
          padding: const EdgeInsets.all(20),
          child: product.imageUrl.startsWith("assets/")
              ? Image.asset(
                  product.imageUrl,
                  fit: BoxFit.fitHeight,
                )
              : Image.network(
                  product.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
        ),
      ],
    );
  }
}
