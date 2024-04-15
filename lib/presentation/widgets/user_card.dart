import 'package:flutter/material.dart';
import 'package:user_app/data/models/user.dart';
import 'package:user_app/presentation/bloc/user_event.dart';
import 'package:user_app/presentation/bloc/user_list_bloc.dart';
import 'package:user_app/presentation/screens/edit_user_screen.dart';

class UserCard extends StatelessWidget {
  final User user;
  final int index;
  final List<String> avatarOptions;
  final UserListBloc userBloc;

  const UserCard({
    super.key,
    required this.user,
    required this.index,
    required this.avatarOptions,
    required this.userBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[50],
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
              : AssetImage(avatarOptions[index % avatarOptions.length]),
        ),
        title: Text(user.name),
        subtitle: Text('${user.email}, ${user.phone}, ${user.address}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            userBloc.add(DeletingUser(index));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User deleted successfully!'),
              ),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditUserScreen(
                name: user.name,
                email: user.email,
                phoneNumber: user.phone,
                address: user.address,
                avatar: user.avatar.isNotEmpty
                    ? user.avatar
                    : avatarOptions[index % avatarOptions.length],
              ),
            ),
          ).then((updatedUser) {
            if (updatedUser != null) {
              userBloc.add(UpdatingUser(index, updatedUser));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User updated successfully!'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to update user. Please try again.'),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
