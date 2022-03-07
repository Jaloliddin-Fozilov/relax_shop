import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String argument;
  final double price;
  final int backgroundcolora;
  final int backgroundcolorr;
  final int backgroundcolorg;
  final int backgroundcolorb;
  int sale;
  bool isNew;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.argument,
    required this.price,
    this.backgroundcolora = 255,
    this.backgroundcolorr = 193,
    this.backgroundcolorg = 7,
    this.backgroundcolorb = 7,
    this.sale = 0,
    this.isNew = false,
    this.isFavorite = false,
  });

  Future<void> toggleLike() async {
    var oldfavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.parse(
        'https://relax-shop-8a725-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final respone = await http.patch(
        url,
        body: jsonEncode({'isFavorite': isFavorite}),
      );
      if (respone.statusCode >= 400) {
        isFavorite = oldfavorite;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldfavorite;
      notifyListeners();
    }
  }
}
