import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int countNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stateful Widget { $countNumber }'),
        backgroundColor: const Color.fromARGB(255, 174, 127, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 178, 255, 180),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $countNumber',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 30),
                backgroundColor: Colors.green,
                foregroundColor: const Color.fromARGB(255, 12, 83, 15),
              ),
              onPressed: () {
                setState(() {
                  countNumber += 2;
                });
              },
              child: Text(
                'Increment +',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 30),
                backgroundColor: Colors.red,
                foregroundColor: const Color.fromARGB(255, 95, 14, 14),
              ),
              onPressed: () {
                setState(() {
                  countNumber -= 2;
                });
              },
              child: Text(
                'Decrement -',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 30),
                backgroundColor: Colors.yellow,
                foregroundColor: const Color.fromARGB(255, 134, 112, 14),
              ),
              onPressed: () {
                setState(() {
                  countNumber = 0;
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}