import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const SimpleApi());
}

class SimpleApi extends StatelessWidget {
  const SimpleApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ApiScreen(),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],);}}
class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});
  @override
  State<ApiScreen> createState() => _ApiScreenState();}
class _ApiScreenState extends State<ApiScreen> {
  List<User> users = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchUsers();}
  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> userList = data['users'];
      setState(() {
        users = userList.map((json) => User.fromJson(json)).toList();
        isLoading = false;});}     else {
      setState(() {
        isLoading = false;});
      throw Exception('Failed to load users');}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple API Call'),
        backgroundColor: const Color.fromARGB(255, 214, 164, 255),
        foregroundColor: Colors.black,
        elevation: 1,),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          // 3. ใช้ ListView.separated และ ListTile ในการแสดงผล
          : ListView.separated(
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: Text(
                    user.id.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  trailing: Text(
                    '(${user.username})',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 80, 29, 87),),),);},),);}}