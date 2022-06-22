import 'package:json_annotation/json_annotation.dart';
part 'cookkugUser.g.dart';

@JsonSerializable()
class CookkugUser {
  final String uid;
  final String name; //정렬할때 고려하기위한 데이터
  final String email;
  final List friends;


  CookkugUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.friends,
  });

  factory CookkugUser.fromJson(json) => _$CookkugUserFromJson(json);
  Map<String, dynamic> toJson() => _$CookkugUserToJson(this);
}
