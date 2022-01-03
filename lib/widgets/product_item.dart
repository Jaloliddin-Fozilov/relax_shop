import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

import '../screens/product_detail_screen.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    void showDetailScreen() {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ProductDetailScreen(
            productId: product.id,
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: product.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () => showDetailScreen(),
        child: GridTile(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
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
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product.sale > 0
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "${product.sale}% chegirma",
                        style: TextStyle(
                          color: product.color,
                        ),
                      ),
                    )
                  : Container(),
              product.isNew
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Yangi",
                        style: TextStyle(
                          color: product.color,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          footer: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: GridTileBar(
              title: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.argument,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () {
                    cart.addtoCart(
                      product.id,
                      product.title,
                      product.imageUrl,
                      product.price,
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
