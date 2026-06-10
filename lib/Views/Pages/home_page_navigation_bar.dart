import 'package:flutter/material.dart';
import 'package:flutter_prm/Views/Widgets/product_list.dart';
import 'package:flutter_prm/Views/Widgets/product_widget.dart';
import 'package:flutter_prm/Views/Widgets/about_widget.dart';
import 'package:flutter_prm/product.dart';

class HomePageNavigationBar extends StatefulWidget {
  const HomePageNavigationBar({super.key});

  @override
  State<HomePageNavigationBar> createState() => _HomePageNavigationBarState();
}

class _HomePageNavigationBarState extends State<HomePageNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Center(child: Text("HomePage")),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            icon: const Icon(Icons.account_box_outlined),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: "Detail"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "About",
          ),
        ],
      ),
      body: [
        ProductList(),
        ProductWidget(product: Product.list[0]),
        const About(),
      ][_selectedIndex],
    );
  }
}
