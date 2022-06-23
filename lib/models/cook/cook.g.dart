// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cook _$CookFromJson(Map<String, dynamic> json) => Cook(
      id: json['id'] as int,
      image: json['image'] as String,
      foodName: json['foodName'] as String,
      cookingTime: json['cookingTime'] as int,
      difficulty: json['difficulty'] as String,
    );

Map<String, dynamic> _$CookToJson(Cook instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'foodName': instance.foodName,
      'cookingTime': instance.cookingTime,
      'difficulty': instance.difficulty,
    };
