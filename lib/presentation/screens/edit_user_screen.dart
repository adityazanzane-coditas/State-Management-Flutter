import 'package:flutter/material.dart';
import '../widgets/user_details.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.avatar,
  });

  final String name, email, phoneNumber, address, avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Details'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: UserDetails(
            name: name,
            email: email,
            address: address,
            phoneNumber: phoneNumber,
            avatar: avatar,
          ),
        ),
      ),
    );
  }
}
