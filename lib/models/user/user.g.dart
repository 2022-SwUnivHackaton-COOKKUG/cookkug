// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      uid: json['uid'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'birthDate': instance.birthDate.toIso8601String(),
      'name': instance.name,
    };
