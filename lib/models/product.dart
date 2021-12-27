import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String description;
  final double price;
  int sale;
  bool isNew;
  bool isFavorite;

  Product({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.sale = 0,
    this.isNew = false,
    this.isFavorite = false,
  });
}
