import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];
  List<Order> get items {
    return [..._items];
  }

  Future<void> getOrdersFromFireBase() async {
    final url = Uri.parse(
        'https://relax-shop-8a725-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) == null) {
        return;
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<Order> loadedOrders = [];
      data.forEach(
        (orderId, orderData) {
          loadedOrders.insert(
            0,
            Order(
              id: orderId,
              totalPrice: orderData['totalPrice'],
              date: DateTime.parse(orderData['date']),
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (product) => CartItem(
                      id: product['id'],
                      title: product['title'],
                      quantity: product['quantity'],
                      price: product['price'],
                      imageUrl: product['image'],
                      backgroundcolor: Colors.amber,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToOrders(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
        'https://relax-shop-8a725-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'totalPrice': totalPrice,
            'date': DateTime.now().toIso8601String(),
            'products': products
                .map(
                  (product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price,
                    'image': product.imageUrl,
                  },
                )
                .toList(),
          },
        ),
      );
      _items.insert(
        0,
        Order(
          id: UniqueKey().toString(),
          totalPrice: totalPrice,
          date: DateTime.now(),
          products: products,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
