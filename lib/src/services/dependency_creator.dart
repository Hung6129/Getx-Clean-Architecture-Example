import 'package:get/get.dart';
import 'package:get_example/src/features/posts/data/data_src/remote/post_api.dart';
import 'package:get_example/src/features/posts/data/repo/post_repository_implement.dart';

import 'package:get_example/src/features/posts/domain/usecases/get_posts_usecase.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => PostApi());
    Get.lazyPut(() => PostRepositoryImplement(Get.find()));
    Get.lazyPut(() => GetPostsUsecases(Get.find()));
  }
}
