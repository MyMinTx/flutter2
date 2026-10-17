import 'package:flutter/material.dart';
import 'package:flutter2/greeting_widget.dart'; // STL

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void login() {
    print("Press !");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo App'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่กลางหน้าจอ
          children: [
            GreetingWidget('Kim Mingyu'),
            const SizedBox(height: 10), // ลบเครื่องหมาย , ด้านหลังออก
            GreetingWidget('Jeon Wonwoo'),
          ],
        ),
      ),
    );
  }
}
