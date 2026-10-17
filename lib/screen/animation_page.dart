import 'package:flutter/material.dart';

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  State<TrafficLightScreen> createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  // สถานะปัจจุบัน: 0 = แดง, 1 = เหลือง, 2 = เขียว
  int _currentState = 0;

  void _changeLight() {
    setState(() {
      _currentState = (_currentState + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Light Animation'),
        backgroundColor: const Color.fromARGB(255, 152, 104, 200),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ไฟแดง
            _buildTrafficLight(color: Colors.red, isActive: _currentState == 0),
            const SizedBox(height: 10),
            // ไฟเหลือง
            _buildTrafficLight(
              color: Colors.yellow,
              isActive: _currentState == 1,
            ),
            const SizedBox(height: 10),
            // ไฟเขียว
            _buildTrafficLight(
              color: Colors.green,
              isActive: _currentState == 2,
            ),
            const SizedBox(height: 30),
            // ปุ่มเปลี่ยนไฟ
            ElevatedButton(
              onPressed: _changeLight,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[50], // สีพื้นหลังปุ่ม
                foregroundColor: Colors.purple, // สีตัวหนังสือ
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('เปลี่ยนไฟ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrafficLight({required Color color, required bool isActive}) {
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
          ],
        ),
      ),
    );
  }
}
