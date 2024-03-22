import 'package:flutter/material.dart';
import 'package:user_app/screens/user_list_screen.dart';

void main() {
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details',
      theme: ThemeData(primaryColor: Colors.amber),
      home: const UserListScreen(),
    );
  }
}
