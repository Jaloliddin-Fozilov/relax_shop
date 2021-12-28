import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

import '../providers/products.dart';

class Productitem extends StatelessWidget {
  const Productitem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {},
      child: GridTile(
        child: Image.network(
          product.imageUrl,
        ),
      ),
    );
  }
}
