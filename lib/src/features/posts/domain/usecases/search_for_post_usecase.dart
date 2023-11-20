import 'package:get_example/src/config/data_state.dart';
import 'package:get_example/src/config/use_case.dart';
import 'package:get_example/src/features/posts/data/repo/post_repository_implement.dart';
import 'package:get_example/src/features/posts/domain/entities/post_entity.dart';

class SearchForPostUseCase
    implements UseCaseWithParams<DataState<List<PostEntity>>, String> {
  final PostRepositoryImplement repository;

  SearchForPostUseCase(this.repository);

  @override
  Future<DataState<List<PostEntity>>> call(String query) async {
    return await repository.searchForPost(query);
  }
}
