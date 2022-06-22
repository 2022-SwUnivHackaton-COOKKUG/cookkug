// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookkugUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookkugUser _$CookkugUserFromJson(Map<String, dynamic> json) => CookkugUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      friends: json['friends'] as List<dynamic>,
    );

Map<String, dynamic> _$CookkugUserToJson(CookkugUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'friends': instance.friends,
    };
