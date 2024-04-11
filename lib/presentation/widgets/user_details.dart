import 'package:flutter/material.dart';
import 'package:user_app/data/models/user.dart';
import 'package:user_app/utils/validators.dart';

class UserDetails extends StatelessWidget {
  UserDetails({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.avatar,
  });

  final String name, email, phoneNumber, address, avatar;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController emailController =
        TextEditingController(text: email);
    final TextEditingController phoneController =
        TextEditingController(text: phoneNumber);
    final TextEditingController addressController =
        TextEditingController(text: address);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CircleAvatar(
            radius: 83,
            backgroundImage: AssetImage(avatar),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(38),
              ),
            ),
            validator: Validators.validateName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(38),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(38),
              ),
            ),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(38),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const SizedBox(width: 82),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newUser = User(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      avatar: '',
                    );
                    Navigator.pop(context, newUser);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
