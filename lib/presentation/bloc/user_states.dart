import 'package:user_app/data/models/user.dart';

abstract class UserState {}

class UserListLoading extends UserState {}

class UserListLoaded extends UserState {
  final List<User> userList;

  UserListLoaded(this.userList);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
