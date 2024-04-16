import 'package:flutter/material.dart';
import 'package:user_app/data/models/user.dart';
import 'package:user_app/presentation/widgets/user_details.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key, this.onUserAdded});
  final Function(User)? onUserAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: UserDetails(
            avatar: 'assets/profile_icon.png',
            name: '',
            email: '',
            phoneNumber: '',
            address: '',
            onUserAdded: onUserAdded,
          ),
        ),
      ),
    );
  }
}
