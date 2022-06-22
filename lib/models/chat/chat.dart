import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final String senderId;
  final String message;
  final String timeStamp;

  Chat({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timeStamp,
  });

  factory Chat.fromJson(json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
