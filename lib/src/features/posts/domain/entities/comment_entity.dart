import 'package:equatable/equatable.dart';
import 'package:get_example/src/features/posts/data/models/comment_model.dart';

class CommentEntity extends Equatable {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const CommentEntity({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  toCommentModel() => CommentModel(
        postId: postId,
        id: id,
        name: name,
        email: email,
        body: body,
      );

  @override
  List<Object?> get props => [postId, id, name, email, body];
}
