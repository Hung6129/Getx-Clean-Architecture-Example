import 'package:get_example/src/config/data_state.dart';
import 'package:get_example/src/features/posts/data/repo/post_repository_implement.dart';
import 'package:get_example/src/features/posts/domain/entities/comment_entity.dart';
import 'package:get_example/src/config/use_case.dart';

class GetPostCommentUsecase
    implements UseCaseWithParams<DataState<List<CommentEntity>>, int> {
  final PostRepositoryImplement postRepositoryImplement;

  GetPostCommentUsecase(this.postRepositoryImplement);

  @override
  Future<DataState<List<CommentEntity>>> call(int params) {
    return postRepositoryImplement.getComment(params);
  }
}
