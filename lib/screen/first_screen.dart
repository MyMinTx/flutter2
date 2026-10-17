import 'package:flutter/material.dart';
import 'package:flutter2/screen/second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/second');
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    SecondScreen(name: 'Kim Mingyu'),
              ),
            );
          },
          child: Text('next page'),
        ),
      ),
    );
  }
}
