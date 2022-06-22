import 'package:cookkug/models/user/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  static UserController get to => Get.find();
  User? user;

  Future<bool> registerUser()async{
    return false;
  }

  Future<bool> loginUser()async{
    return false;
  }
}