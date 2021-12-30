import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routName = "/";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Relax shop",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sevimli buyumingizni tanlang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Ajoyiblik har bir buyumda mujassam",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(
                      child: Text('Barchasi'),
                    ),
                    Tab(
                      child: Text('Sevimli'),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: ProductsGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
