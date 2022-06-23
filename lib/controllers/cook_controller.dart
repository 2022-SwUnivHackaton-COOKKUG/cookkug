import 'package:get/get.dart';
import '../models/cook/cook.dart';

class CookController extends GetxController {
  static CookController get to => Get.find();

  List<Cook> recommendCookList = [
    Cook(id:1,image: 'https://recipe1.ezmember.co.kr/cache/recipe/2020/05/23/128f4433b502ebc9df0bb6ebb494396d1_m.jpg', foodName: '아보카도 샌드위치', cookingTime: 15, difficulty: '하'),
    Cook(id:2,image: 'https://recipe1.ezmember.co.kr/cache/recipe/2019/01/06/8a350cc766ba99e365f53856293f97801_m.jpg', foodName: '두부유부초밥', cookingTime: 10, difficulty: '하'),
    Cook(id:3,image: 'https://recipe1.ezmember.co.kr/cache/recipe/2016/01/24/b883893cfd9dc3dadaa302c3622df7291_m.jpg', foodName: '카프레제', cookingTime: 5, difficulty: '하'),
    Cook(id:4,image: 'https://recipe1.ezmember.co.kr/cache/recipe/2015/04/09/156d49387c0e891cb511a5a37f518a3d1_m.jpg', foodName: '통감자구이', cookingTime: 20, difficulty: '중'),
  ];

}
