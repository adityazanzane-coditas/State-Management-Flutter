import 'package:user_app/data/user_data.dart';

class UserEditData {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String avatarPath;

  UserEditData({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatarPath,
  });

  factory UserEditData.fromUser(User user, String avatarPath) {
    return UserEditData(
      name: user.name,
      email: user.email,
      phone: user.phone,
      address: user.address,
      avatarPath: avatarPath,
    );
  }
}
