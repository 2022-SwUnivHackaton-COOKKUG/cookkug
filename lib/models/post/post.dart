import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final String authorId;
  final String authorName;
  final List image;
  final String note;
  final List hashtagList;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.image,
    required this.note,
    required this.hashtagList,
  });

  factory Post.fromJson(json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
