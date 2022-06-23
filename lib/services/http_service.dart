import 'dart:convert';

import 'package:cookkug/models/recipe/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  // 싱글톤 객체 생성
  static final HttpService _instance = HttpService._initialize();
  factory HttpService() => _instance;
  HttpService._initialize() {
    print('HttpService Initialized');
  }

  Future<List<Recipe>> getRandomRecipe() async {
    try{
      Response getRecipeData =
      await http.get(Uri.parse('http://118.67.128.79:8000/first'));
      final decodeData = utf8.decode(getRecipeData.bodyBytes);
      List result = jsonDecode(decodeData);
      List<Recipe> recipeList = [];
      for (var element in result) {
        Recipe recipe = await getRecipeWithData(element);
        recipeList.add(recipe);
      }
      return recipeList;
    }catch(e){
      print(e);
      return [];
    }

  }

  void getRecipeListWithKeywork(String keyword) async {
    Response getRecipeData =
        await http.get(Uri.parse('http://118.67.128.79:8000/recipe/384508'));
    final decodeData = utf8.decode(getRecipeData.bodyBytes);
    Map<String, dynamic> result = jsonDecode(decodeData);
    getRecipeWithData(result);
  }

  Future<Recipe> getRecipeWithData(Map<String, dynamic> data) async {
    Map<String, dynamic> recipeData = {
      'id': data['레시피일련번호'].toString(),
      'authorId': data['등록자ID'],
      'authorName': data['등록자명'],
      'image': [data['이미지']],
      'recipeName': data['레시피제목'],
      'cookingTime': data['요리시간명'],
      'recipeCategory': data['요리방법별명'],
      'ingredientList': (data['요리재료내용'] as String)
          .replaceAll('[재료]', '')
          .replaceAll(' ', '')
          .split('|')
          .toList(),
      'cookingOrder':[data['조리순서']],
    };
    return Recipe.fromJson(recipeData);
  }
}
