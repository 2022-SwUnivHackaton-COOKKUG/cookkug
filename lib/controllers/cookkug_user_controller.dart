import 'package:cookkug/models/user/cookkugUser.dart';
import 'package:cookkug/services/firebase_service.dart';
import 'package:get/get.dart';

class CookkugUserController extends GetxController {
  static CookkugUserController get to => Get.find();
  CookkugUser? user;

  Future<void> signIn(CookkugUser cookkugUser) async {
    user = cookkugUser;
    update();
  }

  Future<void> signOut() async {
    user = null;
    update();
  }

  Future<List<CookkugUser>> getUserList() async {
    List userList = await FirebaseService().getUserList();
    List<CookkugUser> cookkugUserList = userList.map((e) {
      return CookkugUser.fromJson(e);
    }).toList();
    print('hello : $cookkugUserList');
    return cookkugUserList;
  }
}
