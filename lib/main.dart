import 'package:flutter/material.dart';
import 'package:flutter2/screen/AssigmentWeek5.dart';
// import 'package:flutter2/screen/call_api.dart';
// import 'package:flutter2/screen/first_screen.dart';
// import 'package:flutter2/screen/home_screen1.dart';
// import 'package:flutter2/counter_screen.dart';
// import 'package:flutter2/home_screen.dart';
// import 'package:flutter2/screen/first_form_screen.dart';
//  import 'package:flutter2/screen/simple_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: Assigmentweek5(),
    );
  }
}