import 'package:json_annotation/json_annotation.dart';
part 'cook.g.dart';

@JsonSerializable()
class Cook {
  final int id;
  final String image;
  final String foodName;
  final int cookingTime;
  final String difficulty;

  Cook({
    required this.id,
    required this.image,
    required this.foodName,
    required this.cookingTime,
    required this.difficulty,
  });

  factory Cook.fromJson(json) => _$CookFromJson(json);
  Map<String, dynamic> toJson() => _$CookToJson(this);
}
