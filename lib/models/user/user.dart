import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String uid;
  final DateTime birthDate;
  final String name; //정렬할때 고려하기위한 데이터

  User({
    required this.id,
    required this.uid,
    required this.birthDate,
    required this.name,
  });

  factory User.fromJson(json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
