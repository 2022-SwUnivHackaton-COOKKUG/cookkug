import 'package:cookkug/models/user/cookkugUser.dart';
import 'package:get/get.dart';

class CookkugUserController extends GetxController{
  static CookkugUserController get to => Get.find();
  CookkugUser? user;

  Future<void> signIn(CookkugUser cookkugUser)async{
    user = cookkugUser;
    update();
  }

  Future<void> signOut()async{
    user = null;
    update();
  }
}