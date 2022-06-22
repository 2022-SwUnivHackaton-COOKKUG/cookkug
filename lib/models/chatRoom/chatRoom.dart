import 'package:json_annotation/json_annotation.dart';
part 'chatRoom.g.dart';

@JsonSerializable()
class ChatRoom {
  final String id;
  final List userIdList;
  final List userList; //이를통해 한 채팅방에서 상대방의 이름을 보여주기 위한 데이터 -> {userId,userName}
  final String lastMessage;
  final String lastMessageTimeStamp; //정렬할때 고려하기위한 데이터

  ChatRoom({
    required this.id,
    required this.userIdList,
    required this.userList,
    required this.lastMessage,
    required this.lastMessageTimeStamp,
  });

  factory ChatRoom.fromJson(json) => _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
