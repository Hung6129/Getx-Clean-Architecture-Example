import 'package:get_example/src/config/data_state.dart';
import 'package:get_example/src/features/posts/domain/entities/comment_entity.dart';
import 'package:get_example/src/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts(int page);

  Future<DataState<List<CommentEntity>>> getComment(int id);

  Future<DataState<List<PostEntity>>> searchForPost(String query);
}
