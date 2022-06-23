import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalController {
  SharedPreferences? _sharedPreferences;
  final String _recipeKey = '';

  Future<void> _setSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearSharedPreferences() async {
    if (_sharedPreferences == null) {
      await _setSharedPreferences();
    }
    await _sharedPreferences!.clear();
  }

  Future<void> setRecipeList(List recipeList) async {
    if (_sharedPreferences == null) {
      await _setSharedPreferences();
    }
    List<String>? savedRecipeList = await getRecipeListId();
    await _sharedPreferences!
        .setStringList(_recipeKey, [...savedRecipeList ?? [], ...recipeList]);
  }

  Future<List<String>?> getRecipeListId() async {
    if (_sharedPreferences == null) {
      await _setSharedPreferences();
    }
    return _sharedPreferences!.getStringList(_recipeKey);
  }
}
