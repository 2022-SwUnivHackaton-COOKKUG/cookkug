import 'package:json_annotation/json_annotation.dart';
part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final String id;
  final List image;
  final String recipeName;
  final String cookingTime;
  final String recipeCategory;
  final List ingredientList;
  final List cookingOrder;

  Recipe({
    required this.id,
    required this.image,
    required this.recipeName,
    required this.cookingTime,
    required this.recipeCategory,
    required this.ingredientList,
    required this.cookingOrder,
  });

  factory Recipe.fromJson(json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
