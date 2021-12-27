import 'package:flutter/material.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      imageUrl: 'imageUrl',
      description: 'blue',
      price: 132.45,
    ),
  ];
}
