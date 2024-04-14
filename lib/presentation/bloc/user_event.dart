import 'package:user_app/data/models/user.dart';

abstract class UserEvent {}

class AddingUser extends UserEvent {
  final User newUser;

  AddingUser(this.newUser);
}

class UpdatingUser extends UserEvent {
  final int index;
  final User updatedUser;

  UpdatingUser(this.index, this.updatedUser);
}

class DeletingUser extends UserEvent {
  final int index;

  DeletingUser(this.index);
}

class RetryEvent extends UserEvent {}
