import 'package:cookkug/models/user/user.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:get/get.dart';

class CookkugUserController extends GetxController {
  static CookkugUserController get to => Get.find();
  User? user;

  Future<void> signIn(User cookkugUser) async {
    user = cookkugUser;
    update();
  }

  Future<void> signOut() async {
    user = null;
    update();
  }

  Future<List<User>> getUserList() async {
    List userList = await FirebaseService().getUserList();
    List<User> cookkugUserList = userList.map((e) {
      return User.fromJson(e);
    }).toList();
    print('hello : $cookkugUserList');
    return cookkugUserList;
  }
}
