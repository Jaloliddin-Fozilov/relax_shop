import 'package:flutter/material.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      title: "Santa's hat",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/744/744546.png',
      argument: 'Fabric, clean, red',
      price: 9.90,
      backgroundcolor: Colors.redAccent,
      isNew: true,
    ),
    Product(
      id: 'p2',
      title: "Gloves",
      imageUrl: 'assets/images/gloves.png',
      argument: 'Fabric, clean, blue',
      price: 19.90,
      backgroundcolor: Colors.blueAccent,
      sale: 20,
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: "Game Controller",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331852.png',
      argument: 'Smart, white, game',
      price: 29.90,
      backgroundcolor: Colors.blue[200]!,
      sale: 10,
    ),
    Product(
      id: 'p4',
      title: 'Flash T-shirt',
      imageUrl: 'assets/images/tshirt.png',
      argument: 'Flash, modern, red',
      price: 29.90,
      backgroundcolor: Colors.redAccent[200]!,
      isNew: true,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  Product findById(String productId) {
    return _list.firstWhere(
      (product) => product.id == productId,
    );
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }
}
