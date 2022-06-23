import 'package:json_annotation/json_annotation.dart';
part 'cookkugRecipe.g.dart';

@JsonSerializable()
class CookkugRecipe {
  final String id;
  final String image;
  final String foodName;
  final String authorId;
  final String authorName;

  CookkugRecipe({
    required this.id,
    required this.image,
    required this.foodName,
    required this.authorId,
    required this.authorName,
  });

  factory CookkugRecipe.fromJson(json) => _$CookkugRecipeFromJson(json);
  Map<String, dynamic> toJson() => _$CookkugRecipeToJson(this);
}
