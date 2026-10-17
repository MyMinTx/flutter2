import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile_stats extends StatelessWidget {
  const profile_stats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatColumn('96', 'Posts'),
        _buildStatColumn('2311', 'Followers'),
        _buildStatColumn('97', 'Following'),
      ],
    );
  }
}

Widget _buildStatColumn(String count, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        count,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(label, style: const TextStyle(fontSize: 14)),
    ],
  );
}
