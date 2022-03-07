import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import './product_item.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  bool _init = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .getProductsFromFirebase()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = productsdata.list;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : products.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                    value: products[index],
                    child: const ProductItem(),
                  );
                },
              )
            : const Center(
                child: Text('Mahsulotlar mavjud emas'),
              );
  }
}
