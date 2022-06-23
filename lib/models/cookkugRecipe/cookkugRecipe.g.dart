// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookkugRecipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookkugRecipe _$CookkugRecipeFromJson(Map<String, dynamic> json) =>
    CookkugRecipe(
      id: json['id'] as String,
      image: json['image'] as String,
      foodName: json['foodName'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
    );

Map<String, dynamic> _$CookkugRecipeToJson(CookkugRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'foodName': instance.foodName,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
    };
