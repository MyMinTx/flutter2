import 'package:flutter/material.dart';

// ignore: camel_case_types
class post_grid extends StatelessWidget {
  const post_grid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> myPosts = [
      'assets/mw1.jpg',
      'assets/mw2.jpg',
      'assets/mw3.jpg',
      'assets/mw5.jpg',
      'assets/mw6.jpg',
      'assets/mw7.jpg',
    ];
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: myPosts.map((imagePath) {
        return Image.asset(imagePath, fit: BoxFit.cover);
      }).toList(),
    );
  }
}
