import 'package:flutter/material.dart';
import 'package:user_app/data/user_data.dart';
import 'package:user_app/providers/user_provider.dart';
import 'package:user_app/screens/edit_user_screen.dart';
import 'package:provider/provider.dart';
import 'package:user_app/data/user_edit_data.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  String getAvatarPath(User user, List<String> avatarOptions, int index) {
    return user.avatar.isNotEmpty
        ? user.avatar
        : avatarOptions[index % avatarOptions.length];
  }

  @override
  Widget build(BuildContext context) {
    //Provider
    final userProvider = Provider.of<UserProvider>(context);
    final List<User> users = userProvider.users;

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
        title: const Text(
          'User List',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: users.isEmpty
            ? const Center(
                child: Text(
                  'No users added yet!',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  //User Indexes
                  final user = users[index];

                  return Card(
                    color: Colors.amber[50],
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                      side: const BorderSide(
                        color: Colors.grey, // Custom border color
                        width: 2, // Custom border width
                      ),
                    ),
                    child: ListTile(
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
                                      userProvider.deleteUser(index);
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
                            userProvider.updateUser(index, updatedUser);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
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
              userProvider.addUser(newUser);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
