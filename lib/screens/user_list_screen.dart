import 'package:flutter/material.dart';
import 'package:user_app/data/user_data.dart';
import 'package:user_app/screens/edit_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // Dummy user list
  List<User> users = [
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
      phone: '8888888888',
      address: 'Wardha',
      avatar: '',
    ),
    User(
      name: 'Mayur Shelar',
      email: 'mayur.shelar@coditas.com',
      phone: '9999999999',
      address: 'Wagholi, Pune',
      avatar: '',
    ),
    User(
      name: 'Gaurav Wani',
      email: 'gaurav.wani@coditas.com',
      phone: '7777777777',
      address: 'Jalgoan',
      avatar: '',
    ),
    User(
      name: 'Siddhant Nilange',
      email: 'siddhant.nilange@coditas.com',
      phone: '6666666666',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),

      //If List is Empty
      body: users.isEmpty
          ? const Center(
              child: Text(
                'No users added yet!',
                style: TextStyle(fontSize: 20.0),
              ),
            )

          //Else List
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

                  // Delete Item from list Button
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
                                  setState(() {
                                    users.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  // Navigate to edit screen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEditScreen(
                            user: user,
                            avatarPath: user.avatar.isNotEmpty
                                ? user.avatar
                                : avatarOptions[index %
                                    avatarOptions
                                        .length] // Use the same avatar as in the list
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

      // To add new data in list (Bottom Floating Button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserEditScreen(
                user: User(
                  name: '',
                  email: '',
                  phone: '',
                  address: '',
                  avatar: '',
                ),
                avatarPath: '',
              ),
            ),

            //To handle the data returned from the UserEditScreen after a new user is added or an existing user is edited
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
