import 'package:flutter/material.dart';

// Exercise 4 – App Structure: Scaffold, AppBar, FAB, ThemeData
// Mục tiêu: Thực hành xây dựng cấu trúc màn hình hoàn chỉnh với Theme
// Lưu ý: Dark mode toggle được hiển thị tĩnh (cần StatefulWidget để toggle thực sự)
class AppStructureDemo extends StatelessWidget {
  const AppStructureDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap bằng Theme để áp dụng ThemeData tùy chỉnh cho màn hình này
    return Theme(
      // ThemeData tùy chỉnh: màu seed = indigo, useMaterial3 = true
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light, // Mặc định light mode (tĩnh)
        ),
        useMaterial3: true,
      ),
      child: Scaffold(
        // --- AppBar ---
        appBar: AppBar(
          title: const Text('Exercise 4 – App Structure'),
          // Actions trong AppBar: nhãn "Dark" + Switch toggle
          actions: [
            // Nhãn "Dark" hiển thị trước switch
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Dark', style: TextStyle(fontSize: 14)),
            ),
            // Switch để toggle dark mode (tĩnh vì StatelessWidget)
            // Cần StatefulWidget để thay đổi giá trị và truyền vào MaterialApp
            Switch(
              value: false, // Giá trị tĩnh: light mode
              // onChanged: null → hiển thị nhưng không tương tác được
              onChanged: null,
            ),
          ],
        ),

        // --- Body ---
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'This is a simple screen with theme toggle.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        // --- FloatingActionButton ---
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Hành động khi nhấn FAB (ví dụ: thêm item mới)
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
