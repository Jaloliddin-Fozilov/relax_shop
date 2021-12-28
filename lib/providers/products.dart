import 'package:flutter/material.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      title: "Santa's hat",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/744/744546.png',
      description: 'Fabric, clean, red',
      price: 9.90,
    ),
    Product(
      id: 'p2',
      title: "Gloves",
      imageUrl:
          'https://cdn-icons.flaticon.com/png/512/1540/premium/1540467.png?token=exp=1640711479~hmac=887898ed3707c0e0a2ae0e4989888718',
      description: 'Fabric, clean, blue',
      price: 19.90,
    ),
    Product(
      id: 'p3',
      title: "Game Controller",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331852.png',
      description: 'Smart, white, game',
      price: 29.90,
    ),
    Product(
      id: 'p4',
      title: 'Flash T-shirt',
      imageUrl:
          'https://cdn-icons.flaticon.com/png/512/3005/premium/3005562.png?token=exp=1640712542~hmac=20f9555d3b6afc7de05da96abfe1d671',
      description: 'Flash, modern, red',
      price: 29.90,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }
}
