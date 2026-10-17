import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String name;
  const SecondScreen({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen { $name }')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('back'),
        ),
      ),
    );
  }
}
