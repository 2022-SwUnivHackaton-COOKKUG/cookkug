import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String name; //정렬할때 고려하기위한 데이터
  final String email;
  final String image;
  final List friends;


  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.friends,
  });

  factory User.fromJson(json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
