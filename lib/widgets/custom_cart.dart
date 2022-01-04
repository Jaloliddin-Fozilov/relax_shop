import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';

class CustomCart extends StatelessWidget {
  final IconData icon;
  final String number;
  const CustomCart({
    Key? key,
    required this.icon,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routName);
            },
            icon: Icon(icon)),
        Positioned(
          top: 15,
          right: 12,
          child: Container(
            alignment: Alignment.center,
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
