import 'package:flutter/material.dart';
import 'package:flutter_prm/Lab4/exercise1_core_widgets.dart';
import 'package:flutter_prm/Lab4/exercise2_input_controls.dart';
import 'package:flutter_prm/Lab4/exercise3_layout.dart';
import 'package:flutter_prm/Lab4/exercise4_scaffold.dart';
import 'package:flutter_prm/Lab4/exercise5_debug_fixes.dart';

// Lab 4 Home – danh sách 5 bài tập, điều hướng sang từng màn hình
class Lab4Home extends StatelessWidget {
  const Lab4Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách bài tập và màn hình tương ứng
    final List<Map<String, Object>> exercises = [
      {
        'title': 'Exercise 1 – Core Widgets Demo',
        'screen': const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2 – Input Controls Demo',
        'screen': const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3 – Layout Demo',
        'screen': const LayoutDemo(),
      },
      {
        'title': 'Exercise 4 – App Structure & Theme',
        'screen': const AppStructureDemo(),
      },
      {
        'title': 'Exercise 5 – Common UI Fixes',
        'screen': const CommonUIFixes(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
      ),
      // ListView.separated để hiển thị danh sách bài tập có khoảng cách đều nhau
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(exercises[index]['title'] as String),
              trailing: const Icon(Icons.chevron_right),
              // Điều hướng sang màn hình bài tập tương ứng
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => exercises[index]['screen'] as Widget,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
