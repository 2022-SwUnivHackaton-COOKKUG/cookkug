// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String,
      image: json['image'] as List<dynamic>,
      recipeName: json['recipeName'] as String,
      cookingTime: json['cookingTime'] as String,
      recipeCategory: json['recipeCategory'] as String,
      ingredientList: json['ingredientList'] as List<dynamic>,
      cookingOrder: json['cookingOrder'] as List<dynamic>,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'recipeName': instance.recipeName,
      'cookingTime': instance.cookingTime,
      'recipeCategory': instance.recipeCategory,
      'ingredientList': instance.ingredientList,
      'cookingOrder': instance.cookingOrder,
    };
