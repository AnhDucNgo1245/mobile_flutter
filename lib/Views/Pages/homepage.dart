import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_prm/ViewModel/product_vm.dart';
import 'package:flutter_prm/Views/Pages/productList.dart';
import 'package:flutter_prm/Views/Pages/productDetail.dart';
import 'package:flutter_prm/Views/Pages/cartPage.dart';

// CHỨC NĂNG: Quản lý Tabs chính và ô tìm kiếm sản phẩm.
// LÝ DO DÙNG CONSUMERSTATEFULWIDGET: Cần lưu trạng thái index hiện tại và sử dụng ref để giao tiếp Riverpod.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch từ khóa tìm kiếm để cập nhật TextField khi cần thiết
    final String searchQuery = ref.watch(searchQueryProvider);

    // Xây dựng Widget thân của tab Trang chủ
    final Widget homeTabBody = SingleChildScrollView(
      child: Column(
        children: [
          // Thanh search products bên dưới AppBar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Đẩy từ khóa tìm kiếm lên Provider để cập nhật toàn hệ thống
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = "";
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF000080)),
                ),
              ),
            ),
          ),
          // Các thẻ chứa sản phẩm
          const ProductListWidget(),
        ],
      ),
    );

    // Danh sách các Page tương ứng với BottomNavigationBar
    final List<Widget> pages = [
      homeTabBody,
      const ProductDetail(),
      const CartPage(),
    ];

    return Scaffold(
      // Chỉ hiển thị AppBar của HomePage ở tab 0 (Home)
      // Các tab khác như ProductDetail và CartPage sẽ tự quản lý AppBar của riêng mình
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: const Color(0xFF000080), // Màu Navy
              title: const Text(
                "Products",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true, // Chữ Products ở chính giữa
              elevation: 0,
            )
          : null,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(76),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white, // Background trắng
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF000080), // Màu Navy
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // Nếu người dùng nhấn chọn Tab Product Detail trực tiếp từ thanh điều hướng
            if (index == 1) {
              final products = ref.read(productListProvider);
              // Nếu chưa chọn sản phẩm nào, mặc định hiển thị thông tin sản phẩm đầu tiên
              if (ref.read(selectedProductProvider) == null && products.isNotEmpty) {
                ref.read(selectedProductProvider.notifier).state = products.first;
              }
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.details),
              label: "Product Detail",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
