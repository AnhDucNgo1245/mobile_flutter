import 'package:flutter/material.dart';

// Exercise 5 – Debug & Fix Common UI Errors
// Mục tiêu: Hiểu và sửa các lỗi layout phổ biến trong Flutter
class CommonUIFixes extends StatelessWidget {
  const CommonUIFixes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      // --- Fix 2: SingleChildScrollView tránh overflow ---
      // Bọc toàn bộ body trong SingleChildScrollView để tránh lỗi
      // "A RenderFlex overflowed by X pixels" trên màn hình nhỏ
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================
            // Fix 1: ListView inside Column dùng SizedBox
            // =========================================
            // Lỗi: ListView bên trong Column gây lỗi unbounded height
            // Sửa: Dùng SizedBox với chiều cao cố định HOẶC Expanded (trong Column có height)
            _sectionTitle('Fix 1: ListView inside Column'),
            const SizedBox(height: 8),
            const Text(
              'Lỗi: ListView trong Column → "Vertical viewport was given unbounded height"\n'
              'Sửa: Bọc ListView bằng SizedBox (chiều cao cố định) hoặc Expanded.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            // Ví dụ đã sửa: SizedBox bao ListView với chiều cao giới hạn
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text('List item ${index + 1}'),
                  dense: true,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // =========================================
            // Fix 2: SingleChildScrollView tránh overflow
            // =========================================
            _sectionTitle('Fix 2: SingleChildScrollView cho overflow'),
            const SizedBox(height: 8),
            const Text(
              'Lỗi: Thêm nhiều widget vào Column → thanh đen-vàng overflow.\n'
              'Sửa: Bọc body bằng SingleChildScrollView (như màn hình này đang dùng).',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Màn hình này dùng SingleChildScrollView → không bị overflow.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // =========================================
            // Fix 3: setState() để cập nhật UI
            // =========================================
            _sectionTitle('Fix 3: setState() để cập nhật UI'),
            const SizedBox(height: 8),
            const Text(
              'Lỗi: Thay đổi biến nhưng UI không cập nhật.\n'
              'Sửa: Gọi setState(() { value = newValue; }) bên trong StatefulWidget.\n'
              'StatelessWidget không có setState → giá trị không thay đổi sau khi build.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            // Minh họa code snippet
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '// Sai: giá trị thay đổi nhưng UI không rebuild\n'
                'int count = 0;\n'
                'count++; // UI vẫn hiện 0\n\n'
                '// Đúng: setState kích hoạt rebuild\n'
                'setState(() { count++; });',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // =========================================
            // Fix 4: DatePicker BuildContext
            // =========================================
            _sectionTitle('Fix 4: DatePicker BuildContext hợp lệ'),
            const SizedBox(height: 8),
            const Text(
              'Lỗi: Gọi showDatePicker() sau async gap hoặc từ initState()\n'
              '→ "This widget\'s context is no longer valid"\n'
              'Sửa: Gọi từ onPressed hoặc kiểm tra mounted trước khi gọi.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            // Ví dụ đúng: gọi showDatePicker từ context hợp lệ trong onPressed
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: const Text('Open DatePicker (Fixed)'),
                onPressed: () {
                  // Đúng: gọi từ context hợp lệ trong widget tree
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper widget: tiêu đề section
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }
}
