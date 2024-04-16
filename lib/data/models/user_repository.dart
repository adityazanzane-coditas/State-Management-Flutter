import 'package:user_app/data/models/user.dart';

class UserRepository {
  List<User> fetchUsers() {
    return [
      User(
        name: 'Aditya Zanzane',
        email: 'aditya.zanzane@coditas.com',
        phone: '9823875384',
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
  }
}
