import 'package:get/get.dart';
import 'package:get_example/src/features/drawer/presentation/controller/drawer_controller.dart';
import 'package:get_example/src/features/posts/data/data_src/remote/post_api.dart';
import 'package:get_example/src/features/posts/data/repo/post_repository_implement.dart';
import 'package:get_example/src/features/posts/domain/usecases/get_post_comment_usecase.dart';

import 'package:get_example/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:get_example/src/features/posts/domain/usecases/search_for_post_usecase.dart';
import 'package:get_example/src/features/posts/presentation/controllers/post_controller.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => PostApi());
    Get.lazyPut(() => PostRepositoryImplement(Get.find()));
    Get.lazyPut(() => GetPostsUsecases(Get.find()));
    Get.lazyPut(() => GetPostCommentUsecase(Get.find()));
    Get.lazyPut(() => SearchForPostUseCase(Get.find()));
    Get.lazyPut(
      () => PostController(
        getPostsUsecases: Get.find(),
        getPostCommentUsecase: Get.find(),
        searchForPostUseCase: Get.find(),
      ),
    );

    Get.lazyPut(() => ZoomDrawerCon());
  }
}
