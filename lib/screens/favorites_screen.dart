import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:emojis/emoji.dart'; // to use Emoji utilities

import '../widgets/product_item.dart';
import '../providers/products.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = productsdata.favorites;
    List<Emoji> emList = Emoji.all();

    return products.length > 0
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
        : Center(
            child: Text("Mahsulotga ${emList[3214]} bosing!"),
          );
  }
}
