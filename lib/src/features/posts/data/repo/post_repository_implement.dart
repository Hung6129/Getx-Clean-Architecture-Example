import 'package:dio/dio.dart';
import 'package:get_example/src/config/data_state.dart';
import 'package:get_example/src/features/posts/data/data_src/remote/post_api.dart';
import 'package:get_example/src/features/posts/data/models/comment_model.dart';
import 'package:get_example/src/features/posts/data/models/post_model.dart';
import 'package:get_example/src/features/posts/domain/repo/post_repository.dart';

class PostRepositoryImplement implements PostRepository {
  final PostApi postApi;

  PostRepositoryImplement(this.postApi);
  @override
  Future<DataState<List<PostModel>>> getPosts() async {
    try {
      final res = await postApi.getPosts();
      if (res.statusCode == 200) {
        return DataSuccess(
          res.data.map<PostModel>((e) => PostModel.fromJson(e)).toList(),
        );
      } else {
        return DataError(
          DioException(
            requestOptions: res.requestOptions,
            response: res,
            error: res.data.toString(),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<CommentModel>>> getComment(int id) async {
    try {
      final res = await postApi.getComment(id);
      if (res.statusCode == 200) {
        return DataSuccess(
          res.data.map<CommentModel>((e) => CommentModel.fromJson(e)).toList(),
        );
      } else {
        return DataError(
          DioException(
            requestOptions: res.requestOptions,
            response: res,
            error: res.data.toString(),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }
}
