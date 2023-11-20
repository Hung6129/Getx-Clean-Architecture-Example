import 'package:get_example/src/config/data_state.dart';
import 'package:get_example/src/config/use_case.dart';
import 'package:get_example/src/features/posts/data/repo/post_repository_implement.dart';
import 'package:get_example/src/features/posts/domain/entities/post_entity.dart';

class GetPostsUsecases
    implements UseCaseWithParams<DataState<List<PostEntity>>, int> {
  final PostRepositoryImplement postRepositoryImplement;

  GetPostsUsecases(this.postRepositoryImplement);

  @override
  Future<DataState<List<PostEntity>>> call(int params) async {
    return postRepositoryImplement.getPosts(params);
  }
}
