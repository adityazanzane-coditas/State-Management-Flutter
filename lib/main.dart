import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data/models/user_repository.dart';
import 'package:user_app/presentation/bloc/user_list_bloc.dart';
import 'package:user_app/presentation/screens/user_list_screen.dart';

void main() {
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details',
      home: BlocProvider(
        create: (context) => UserListBloc(userRepository: UserRepository()),
        child: const UserListScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
