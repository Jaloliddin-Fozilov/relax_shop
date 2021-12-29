import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String argument;
  final double price;
  final Color color;
  int sale;
  bool isNew;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.argument,
    required this.price,
    this.color = Colors.white,
    this.sale = 0,
    this.isNew = false,
    this.isFavorite = false,
  });
}
