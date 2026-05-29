import 'package:flutter/material.dart';

// Exercise 3 – Layout Basics: Column, Row, Padding, ListView
// Mục tiêu: Xây dựng UI layout phân chia section giống màn hình Home thực tế
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  // Danh sách phim tĩnh (không cần setState)
  static const List<String> _movies = [
    'Avatar',
    'Inception',
    'Interstellar',
    'Joker',
    'The Dark Knight',
    'Titanic',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      // Column tạo layout dọc cho toàn màn hình
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Section Header dùng Padding ---
          // Padding tạo khoảng cách xung quanh tiêu đề section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // --- ListView.builder bên trong Expanded ---
          // Expanded cho phép ListView chiếm phần còn lại của Column
          // Tránh lỗi "RenderFlex children have non-zero flex but incoming height constraints are unbounded"
          Expanded(
            child: ListView.builder(
              // Padding theo chiều ngang cho toàn bộ list
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                // Padding bên dưới mỗi item tạo khoảng cách đều 8px
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    // Row bên trong mỗi item (CircleAvatar + Column thông tin)
                    child: ListTile(
                      // CircleAvatar hiển thị chữ cái đầu của tên phim
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text(
                          _movies[index][0], // Lấy ký tự đầu tiên
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      title: Text(_movies[index]),
                      subtitle: const Text('Sample description'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
