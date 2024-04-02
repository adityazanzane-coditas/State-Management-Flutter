import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_app/data/user_data.dart';
import 'package:user_app/screens/add_user_screen.dart';
import 'package:user_app/state/user_riverpod.dart';
import 'package:user_app/screens/edit_user_screen.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  String getAvatarPath(User user, List<String> avatarOptions, int index) {
    return user.avatar.isNotEmpty
        ? user.avatar
        : avatarOptions[index % avatarOptions.length];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userRiverpod);

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
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 2,
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
                                      ref
                                          .read(userRiverpod.notifier)
                                          .deleteUser(index);
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
                                name: user.name,
                                address: user.address,
                                phoneNumber: user.phone,
                                email: user.email,
                                avatar:
                                    getAvatarPath(user, avatarOptions, index)),
                          ),
                        ).then((updatedUser) {
                          if (updatedUser != null) {
                            ref
                                .read(userRiverpod.notifier)
                                .updateUser(index, updatedUser);
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
              builder: (context) => const AddUserScreen(),
            ),
          ).then((newUser) {
            if (newUser != null) {
              ref.read(userRiverpod.notifier).addUser(newUser);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
