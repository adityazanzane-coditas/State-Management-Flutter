import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data/models/user.dart';
import 'package:user_app/data/models/user_repository.dart';
import 'package:user_app/presentation/bloc/user_event.dart';
import 'package:user_app/presentation/bloc/user_states.dart';

class UserListBloc extends Bloc<UserEvent, UserState> {
  late List<User> userList;
  final UserRepository userRepository;

  UserListBloc({required this.userRepository}) : super(UserListLoading()) {
    on<AddingUser>(_onAddingUser);
    on<UpdatingUser>(_onUpdatingUser);
    on<DeletingUser>(_onDeletingUser);
    on<RetryEvent>(_onRetryEvent);

    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      userList = userRepository.fetchUsers();
      // ignore: invalid_use_of_visible_for_testing_member
      emit(UserListLoaded(List.from(userList)));
    } catch (error) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(UserErrorState(error.toString()));
    }
  }

  Future<void> _addUser(User newUser, Emitter<UserState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      if (random.nextBool()) {
        userList.add(newUser);
        emit(UserListLoaded(List.from(userList)));
      } else {
        emit(UserErrorState('Failed to add user. Please try again.'));
      }
    } catch (error) {
      emit(UserErrorState(error.toString()));
    }
  }

  Future<void> _updateUser(
      int index, User updatedUser, Emitter<UserState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      if (random.nextBool()) {
        userList[index] = updatedUser;
        emit(UserListLoaded(List.from(userList)));
      } else {
        emit(UserErrorState('Failed to update user. Please try again.'));
      }
    } catch (error) {
      emit(UserErrorState(error.toString()));
    }
  }

  void _onAddingUser(AddingUser event, Emitter<UserState> emit) async {
    emit(UserListLoading());
    await _addUser(event.newUser, emit);
  }

  void _onUpdatingUser(UpdatingUser event, Emitter<UserState> emit) async {
    emit(UserListLoading());
    await _updateUser(event.index, event.updatedUser, emit);
  }

  void _onDeletingUser(DeletingUser event, Emitter<UserState> emit) {
    userList.removeAt(event.index);
    emit(UserListLoaded(List.from(userList)));
  }

  void _onRetryEvent(RetryEvent event, Emitter<UserState> emit) {
    _fetchUsers();
  }
}
