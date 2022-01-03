import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  void addtoCart(
    String productId,
    String title,
    String imageUrl,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (currentProduct) => CartItem(
          id: currentProduct.id,
          title: currentProduct.title,
          quantity: currentProduct.quantity + 1,
          price: currentProduct.price,
          imageUrl: currentProduct.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: UniqueKey().toString(),
          title: title,
          quantity: 1,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }
}
