import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false)
        .findById(widget.productId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            height: 350,
            color: product.color,
            child: GridTile(
              header: Container(
                margin: const EdgeInsets.only(top: 50),
                child: GridTileBar(
                  title: const SizedBox(),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 28,
                    ),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(40.0),
                child: product.imageUrl.startsWith("assets/")
                    ? Image.asset(
                        product.imageUrl,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.network(
                        product.imageUrl,
                        fit: BoxFit.fitHeight,
                      ),
              ),
              footer: GridTileBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.remove_circle,
                      ),
                      color: Colors.white60,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle,
                      ),
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: product.color,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(25),
                  topEnd: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: product.sale > 0
                        ? Text(
                            "${product.sale}% chegirma",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          )
                        : const SizedBox(),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          product.toggleLike();
                        });
                      },
                      icon: Icon(
                        !product.isFavorite
                            ? Icons.favorite_outline
                            : Icons.favorite_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      product.argument,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Umumiy narxi:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Container(
                child: !product.isFavorite
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Savatchaga qo'shish",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          cart.addtoCart(
                            product.id,
                            product.title,
                            product.imageUrl,
                            product.price,
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 14,
                        ),
                        label: const Text("Savatchaga borish"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[300],
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
