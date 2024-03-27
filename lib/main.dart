import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/user_provider.dart';
import 'package:user_app/screens/user_list_screen.dart';

void main() {
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MaterialApp(
        title: 'User Details',
        home: UserListScreen(),
      ),
    );
  }
}
