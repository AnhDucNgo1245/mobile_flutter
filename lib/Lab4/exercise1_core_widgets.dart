import 'package:flutter/material.dart';

// Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile
// Mục tiêu: Xây dựng UI đơn giản thể hiện các widget hiển thị cơ bản của Flutter
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 – Core Widgets')),
      // SingleChildScrollView để tránh overflow trên màn hình nhỏ
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Text Widget ---
            // Hiển thị tiêu đề với kiểu chữ đậm, cỡ lớn
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // --- Icon Widget ---
            // Sử dụng Material Icons để hiển thị biểu tượng phim
            const Center(
              child: Icon(Icons.movie, size: 80, color: Colors.blue),
            ),
            const SizedBox(height: 16),

            // --- Image.network Widget ---
            // Tải và hiển thị ảnh từ URL, có bo góc và xử lý lỗi
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/200/300?grayscale', // Dùng picsum.photos – hỗ trợ CORS trên web
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                // Hiển thị icon khi ảnh không load được
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
                ),
                // Hiển thị loading indicator trong khi tải ảnh
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // --- Card + ListTile Widget ---
            // Card bọc ListTile để tạo hiệu ứng nổi và bo góc
            Card(
              child: ListTile(
                leading: const Icon(Icons.star), // Icon dẫn đầu
                title: const Text('Movie Item'),
                subtitle: const Text(
                  'This is a sample ListTile inside a Card.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
