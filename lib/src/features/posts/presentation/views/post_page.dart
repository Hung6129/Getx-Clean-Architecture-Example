import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/posts/presentation/controllers/post_controller.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<PostController>(PostController(getPostsUsecases: Get.find()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Page'),
      ),
      body: Obx(
        () => controller.loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : controller.posts.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : ListView.builder(
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return ListTile(
                        onTap: () {
                          controller.goToPostDetail(post);
                        },
                        leading: Text(post.id.toString()),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    },
                  ),
      ),
    );
  }
}
