import 'package:get/get.dart';
import 'package:get_example/src/features/posts/data/models/post_model.dart';

import 'package:get_example/src/features/posts/domain/usecases/get_posts_usecase.dart';

class PostController extends GetxController {
  final GetPostsUsecases getPostsUsecases;
  PostController({required this.getPostsUsecases});

  final _posts = <PostModel>[].obs;
  List<PostModel> get posts => _posts;

  final _loading = false.obs;

  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    _getPosts();
  }

  Future<void> _getPosts() async {
    _loading.value = true;
    final result = await getPostsUsecases.call(null);
    if (result.data != null && result.data!.isNotEmpty) {
      for (var element in result.data!) {
        _posts.add(element.toPostModel());
      }
      _loading.value = false;
    } else {
      _loading.value = false;
      Get.snackbar(
        'Error',
        result.error!.error.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void goToPostDetail(PostModel post) {
    Get.toNamed('/post-detail', arguments: post);
  }
}
