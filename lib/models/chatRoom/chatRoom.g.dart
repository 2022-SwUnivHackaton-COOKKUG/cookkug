// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatRoom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      id: json['id'] as String,
      userIdList: json['userIdList'] as List<dynamic>,
      userList: json['userList'] as List<dynamic>,
      lastMessage: json['lastMessage'] as String,
      lastMessageTimeStamp: json['lastMessageTimeStamp'] as String,
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'userIdList': instance.userIdList,
      'userList': instance.userList,
      'lastMessage': instance.lastMessage,
      'lastMessageTimeStamp': instance.lastMessageTimeStamp,
    };
