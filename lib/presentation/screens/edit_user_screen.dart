import 'package:flutter/material.dart';
import 'package:user_app/presentation/widgets/user_details.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({
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
