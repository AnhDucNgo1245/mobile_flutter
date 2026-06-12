import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_prm/Views/Pages/homepage.dart';
import 'package:flutter_prm/Lab6/lab6_responsive_ui.dart';
// ĐỐI CHIẾU CŨ:
// void main() {
//   runApp(const MyApp());
// }
//
// ĐỐI CHIẾU MỚI (RIVERPOD):
// Bọc ứng dụng trong ProviderScope để khởi tạo môi trường lưu trữ trạng thái của Riverpod.
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ĐỐI CHIẾU CŨ:
      // home: const Lab5HomePage(),
      //
      // ĐỐI CHIẾU MỚI:
      // Trỏ trực tiếp vào HomePage mới xây dựng bằng Riverpod
      home: const GenreScreen(),
    );
  }
}
