import 'package:flutter/material.dart';
import 'package:flutter_prm/Lab5/View/Pages/product_list_page.dart';

class Lab5HomePage extends StatefulWidget {
  const Lab5HomePage({super.key});

  @override
  State<Lab5HomePage> createState() => _Lab5HomePageState();
}

class _Lab5HomePageState extends State<Lab5HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: const Icon(Icons.star, color: Colors.black),
        title: const Text(
          "Minions Shop - Lab 5",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: const ProductListPage(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: InkWell(
            onTap: () {
              // Nhấp vào nút Home thì không cần làm gì vì đang ở Home rồi
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: Colors.amber[800]),
                Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.amber[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
