import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile_header extends StatelessWidget {
  const profile_header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        image: const DecorationImage(
          image: AssetImage('assets/mw4.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
