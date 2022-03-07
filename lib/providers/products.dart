import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../services/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    // Product(
    //   id: 'p1',
    //   title: "Santa's hat",
    //   imageUrl: 'https://cdn-icons-png.flaticon.com/512/744/744546.png',
    //   argument: 'Fabric, clean, red',
    //   price: 9.90,
    //   backgroundcolor: Colors.redAccent,
    //   isNew: true,
    // ),
    // Product(
    //   id: 'p2',
    //   title: "Gloves",
    //   imageUrl: '/assets/images/gloves.png',
    //   argument: 'Fabric, clean, blue',
    //   price: 19.90,
    //   backgroundcolor: Colors.blueAccent,
    //   sale: 20,
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p3',
    //   title: "Game Controller",
    //   imageUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331852.png',
    //   argument: 'Smart, white, game',
    //   price: 29.90,
    //   backgroundcolor: Colors.blue[200]!,
    //   sale: 10,
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Flash T-shirt',
    //   imageUrl: '/assets/images/tshirt.png',
    //   argument: 'Flash, modern, red',
    //   price: 29.90,
    //   backgroundcolor: Colors.redAccent[200]!,
    //   isNew: true,
    // ),
  ];

  List<Product> get list {
    return [..._list];
  }

  Future<void> getProductsFromFirebase() async {
    final url = Uri.parse(
        'https://relax-shop-8a725-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final List<Product> loadedProducts = [];
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        data.forEach((productId, productData) {
          loadedProducts.add(
            Product(
                id: productId,
                title: productData['title'],
                imageUrl: productData['imageUrl'],
                argument: productData['argument'],
                price: productData['price'],
                backgroundcolora: productData['backgroundcolora'],
                backgroundcolorr: productData['backgroundcolorr'],
                backgroundcolorg: productData['backgroundcolorg'],
                backgroundcolorb: productData['backgroundcolorb'],
                isNew: productData['isNew'],
                sale: productData['sale']),
          );
        });

        _list = loadedProducts;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Product findById(String productId) {
    return _list.firstWhere(
      (product) => product.id == productId,
    );
  }

  Future<void> addProduct(Product product) async {
    try {
      final url = Uri.parse(
          'https://relax-shop-8a725-default-rtdb.firebaseio.com/products.json');
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': product.title,
            'argument': product.argument,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isNew': product.isNew,
            'sale': product.sale,
            'backgroundcolora': product.backgroundcolora,
            'backgroundcolorr': product.backgroundcolorr,
            'backgroundcolorg': product.backgroundcolorg,
            'backgroundcolorb': product.backgroundcolorb,
          },
        ),
      );
      final name = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
        id: name,
        title: product.title,
        imageUrl: product.imageUrl,
        argument: product.argument,
        price: product.price,
        isNew: product.isNew,
        sale: product.sale,
        backgroundcolora: product.backgroundcolora,
        backgroundcolorr: product.backgroundcolorr,
        backgroundcolorg: product.backgroundcolorg,
        backgroundcolorb: product.backgroundcolorb,
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://relax-shop-8a725-default-rtdb.firebaseio.com/products/$id.json');
    try {
      var productIndex = _list.indexWhere((product) => product.id == id);
      var deletingProduct = _list.firstWhere((product) => product.id == id);
      _list.removeWhere((product) => product.id == id);

      notifyListeners();
      final respone = await http.delete(url);
      if (respone.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpExeption('Mahsulot o\'chirishda xatolik yuz berdi');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final productIndex = _list.indexWhere(
      (product) => product.id == updatedProduct.id,
    );
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://relax-shop-8a725-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json');
      try {
        await http.patch(
          url,
          body: jsonEncode(
            {
              'title': updatedProduct.title,
              'argument': updatedProduct.argument,
              'price': updatedProduct.price,
              'imageUrl': updatedProduct.imageUrl,
              'sale': updatedProduct.sale,
              'backgroundcolora': updatedProduct.backgroundcolora,
              'backgroundcolorr': updatedProduct.backgroundcolorr,
              'backgroundcolorg': updatedProduct.backgroundcolorg,
              'backgroundcolorb': updatedProduct.backgroundcolorb,
            },
          ),
        );
        _list[productIndex] = updatedProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }
}
