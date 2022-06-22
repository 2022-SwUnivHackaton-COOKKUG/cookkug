// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      message: json['message'] as String,
      timeStamp: json['timeStamp'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'message': instance.message,
      'timeStamp': instance.timeStamp,
    };
