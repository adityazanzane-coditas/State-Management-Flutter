import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/core/constants.dart';
import 'package:user_app/data/models/user.dart';
import 'package:user_app/data/models/user_repository.dart';
import 'package:user_app/presentation/bloc/user_event.dart';
import 'package:user_app/presentation/bloc/user_list_bloc.dart';
import 'package:user_app/presentation/bloc/user_states.dart';
import 'package:user_app/presentation/screens/add_user_screen.dart';
import 'package:user_app/presentation/widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  String getAvatarPath(User user, List<String> avatarOptions, int index) {
    return user.avatar.isNotEmpty
        ? user.avatar
        : avatarOptions[index % avatarOptions.length];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserListBloc(userRepository: UserRepository()),
      child: BlocBuilder<UserListBloc, UserState>(
        builder: (context, state) {
          final userBloc = BlocProvider.of<UserListBloc>(context);

          if (state is UserListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserListLoaded) {
            final List<User> users = state.userList;

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
                          final user = users[index];

                          return UserCard(
                            user: user,
                            index: index,
                            avatarOptions: Constants.avatarOptions,
                            userBloc: userBloc,
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
                      userBloc.add(AddingUser(newUser));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User added successfully!'),
                        ),
                      );
                    }
                  });
                },
                child: const Icon(Icons.add),
              ),
            );
          } else if (state is UserErrorState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.error}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        userBloc.add(RetryEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
