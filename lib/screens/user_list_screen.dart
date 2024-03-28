import 'package:flutter/material.dart';
import 'package:user_app/data/user_data.dart';
import 'package:user_app/screens/edit_user_screen.dart';
import 'package:user_app/data/user_edit_data.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen();

  String getAvatarPath(User user, List<String> avatarOptions, int index) {
    return user.avatar.isNotEmpty
        ? user.avatar
        : avatarOptions[index % avatarOptions.length];
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(
        name: 'Aditya Zanzane',
        email: 'aditya.zanzane@coditas.com',
        phone: '9898989898',
        address: 'PCMC, Pune',
        avatar: '',
      ),
      User(
        name: 'Yash Wadatkar',
        email: 'yash.wadatkar@coditas.com',
        phone: '8269875249',
        address: 'Sawangi, Wardha',
        avatar: '',
      ),
      User(
        name: 'Mayur Shelar',
        email: 'mayur.shelar@coditas.com',
        phone: '9881723490',
        address: 'Wagholi, Pune',
        avatar: '',
      ),
      User(
        name: 'Gaurav Wani',
        email: 'gaurav.wani@coditas.com',
        phone: '7749569023',
        address: 'Gurudatta Society, Jalgoan',
        avatar: '',
      ),
      User(
        name: 'Siddhant Nilange',
        email: 'siddhant.nilange@coditas.com',
        phone: '8662364538',
        address: 'Parbhani',
        avatar: '',
      ),
    ];

    final List<String> avatarOptions = [
      'assets/lion_avatar.png',
      'assets/shark_avatar.png',
      'assets/skull_avatar.png',
      'assets/tiger_avatar.png',
      'assets/cow_avatar.png',
      'assets/giraffe_avatar.png',
      'assets/mouse_avatar.png',
      'assets/octopus_avatar.png',
      'assets/owl_avatar.png',
      'assets/robot_avatar.png',
      'assets/pig_avatar.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: users.isEmpty
          ? const Center(
              child: Text(
                'No users added yet!',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.avatar.isNotEmpty
                        ? AssetImage(user.avatar)
                        : AssetImage(
                            avatarOptions[index % avatarOptions.length]),
                  ),
                  title: Text(user.name),
                  subtitle:
                      Text('${user.email}, ${user.phone}, ${user.address}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                                'Are you sure you want to delete this user?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Update the UI with setState
                                  setState(() {
                                    users.removeAt(index);
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEditScreen(
                          userEditData: UserEditData.fromUser(
                            user,
                            getAvatarPath(user, avatarOptions, index),
                          ),
                        ),
                      ),
                    ).then((updatedUser) {
                      if (updatedUser != null) {
                        setState(() {
                          users[index] = updatedUser;
                        });
                      }
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserEditScreen(
                userEditData: UserEditData(
                  name: '',
                  email: '',
                  phone: '',
                  address: '',
                  avatarPath: getAvatarPath(
                    User(
                      name: '',
                      email: '',
                      phone: '',
                      address: '',
                      avatar: '',
                    ),
                    avatarOptions,
                    0,
                  ),
                ),
              ),
            ),
          ).then((newUser) {
            if (newUser != null) {
              setState(() {
                users.add(newUser);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
