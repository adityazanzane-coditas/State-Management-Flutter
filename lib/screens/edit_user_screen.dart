import 'package:flutter/material.dart';
import 'package:user_app/data/user_data.dart';
import 'package:user_app/data/user_edit_data.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({
    super.key,
    required this.userEditData,
  });

  final UserEditData userEditData;

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  // Updating Ui of TextField
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  @override
  // Initialization Logic
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userEditData.name);
    _emailController = TextEditingController(text: widget.userEditData.email);
    _phoneController = TextEditingController(text: widget.userEditData.phone);
    _addressController =
        TextEditingController(text: widget.userEditData.address);
  }

  @override
  // Removing State Object no longer needed
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            // Wrap with Form widget

            key: _formKey, // Assign the key
            autovalidateMode: AutovalidateMode.always, // Enable auto-validation

            child: Column(
              children: [
                // Field to enter the values
                CircleAvatar(
                  radius: 83,
                  backgroundImage: widget.user.avatar.isNotEmpty
                      ? AssetImage(widget.user.avatar)
                      : AssetImage(
                          widget.avatarPath), // Default avatar image path
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address (e.g., example@gmail.com)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10, // Limit to 10 digits
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  maxLength: 50, // Limit to 50 words
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Validate the form
                          final updatedUser = User(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            avatar: widget.user.avatar,
                          );
                          //Pop with updated list
                          Navigator.pop(context, updatedUser);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
