import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/posts/presentation/controllers/post_controller.dart';

class PostPage extends GetView<PostController> {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Posts Page'),
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.open();
            },
            icon: const Icon(Icons.menu),
          )),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onTapOutside: (value) {
                  controller.searchFocusNode.unfocus();
                },
                controller: controller.searchController,
                focusNode: controller.searchFocusNode,
                onChanged: (value) {
                  controller.searchController.text = value;
                  controller.searchForPost(controller.searchController.text);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.searchController.clear();
                      controller.onRefresh();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            controller.loading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : controller.posts.isEmpty
                    ? const Center(child: Text('No data'))
                    : Expanded(
                        child: RefreshIndicator(
                          backgroundColor: Colors.black,
                          color: Colors.white,
                          onRefresh: () async {
                            await Future.delayed(const Duration(seconds: 1));
                            controller.onRefresh();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.posts.length,
                            itemBuilder: (context, index) {
                              final post = controller.posts[index];
                              return ListTile(
                                onTap: () {
                                  controller.getPostComment(post.id);
                                },
                                leading: Text(post.id.toString()),
                                title: Text(post.title),
                                subtitle: Text(post.body),
                              );
                            },
                          ),
                        ),
                      ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: controller.showFABValue ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                heroTag: 'btn1',
                onPressed: () {
                  controller.srcollToTop();
                },
                child: const Icon(Icons.arrow_upward),
              ),
              const SizedBox(height: 10),
              FloatingActionButton.small(
                heroTag: 'btn2',
                onPressed: () {
                  controller.srcollToBottom();
                },
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
