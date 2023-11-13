import 'package:get_example/src/features/posts/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.postId,
    required super.id,
    required super.name,
    required super.email,
    required super.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'postId': super.postId,
        'id': super.id,
        'name': super.name,
        'email': super.email,
        'body': super.body,
      };
}
