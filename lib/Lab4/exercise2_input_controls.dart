import 'package:flutter/material.dart';

// Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker
// Mục tiêu: Xây dựng UI tương tác cho phép người dùng điều khiển các giá trị
// Lưu ý: Dùng StatelessWidget nên các giá trị là tĩnh (không cập nhật live)
class InputControlsDemo extends StatelessWidget {
  const InputControlsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls'),
      ),
      // SingleChildScrollView để tránh overflow khi bàn phím mở
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Slider Widget ---
            // Thanh trượt để chọn giá trị trong khoảng (0 – 100)
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Giá trị tĩnh = 50, onChanged = null vì StatelessWidget không có setState
            Slider(
              value: 50,
              min: 0,
              max: 100,
              // onChanged: null → slider bị vô hiệu hóa (cần StatefulWidget để tương tác)
              onChanged: null,
            ),
            const Text('Current value: 50'),
            const SizedBox(height: 20),

            // --- Switch Widget ---
            // Công tắc bật/tắt trạng thái
            const Text(
              'Active (Switch)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // SwitchListTile kết hợp Switch và nhãn tiện lợi
            // value: false (tĩnh), onChanged: null vì StatelessWidget
            SwitchListTile(
              title: const Text('Is movie active?'),
              value: false,
              // onChanged: null → switch hiển thị nhưng không thay đổi được
              onChanged: null,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),

            // --- RadioListTile Widget ---
            // Nhóm nút radio để chọn một giá trị trong danh sách
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // groupValue: null → không có lựa chọn nào (tĩnh, StatelessWidget)
            // Dùng RadioGroup làm ancestor để quản lý trạng thái theo Flutter 3.32+
            RadioGroup<String>(
              groupValue: null,
            onChanged: (_) {}, // StatelessWidget: không xử lý thay đổi
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Action'),
                    value: 'Action',
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    title: const Text('Comedy'),
                    value: 'Comedy',
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const Text('Selected genre: None'),
            const SizedBox(height: 20),

            // --- DatePicker Button ---
            // showDatePicker là hàm async trả về Future, hoạt động được với StatelessWidget
            Center(
              child: TextButton(
                onPressed: () {
                  // Gọi showDatePicker từ context hợp lệ trong widget tree
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  // Lưu ý: Kết quả trả về không hiển thị vì không có setState
                },
                child: const Text('Open Date Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
