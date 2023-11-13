import 'package:equatable/equatable.dart';
import 'package:get_example/src/features/posts/data/models/post_model.dart';

class PostEntity extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  toPostModel() {
    return PostModel(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }

  @override
  List<Object?> get props => [id, userId, title, body];
}
