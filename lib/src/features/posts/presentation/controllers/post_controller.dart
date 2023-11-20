import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/posts/data/models/comment_model.dart';

import 'package:get_example/src/features/posts/data/models/post_model.dart';
import 'package:get_example/src/features/posts/domain/usecases/get_post_comment_usecase.dart';

import 'package:get_example/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:get_example/src/features/posts/domain/usecases/search_for_post_usecase.dart';
import 'package:get_example/src/features/posts/presentation/views/post_detail_comment_page.dart';

class PostController extends GetxController {
  final GetPostsUsecases getPostsUsecases;
  final GetPostCommentUsecase getPostCommentUsecase;
  final SearchForPostUseCase searchForPostUseCase;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  PostController({
    required this.getPostsUsecases,
    required this.getPostCommentUsecase,
    required this.searchForPostUseCase,
  });

  final _posts = <PostModel>[].obs;
  List<PostModel> get posts => _posts;

  final _loading = false.obs;
  bool get loading => _loading.value;

  int page = 1;

  final _showFAB = true.obs;
  bool get showFABValue => _showFAB.value;

  ScrollController scrollController = ScrollController();

  /// init state of controller
  @override
  void onInit() {
    _getPosts();
    onScroll();
    onSrcollHideFAB();
    super.onInit();
  }

  /// dispose state of controller
  @override
  void onClose() {
    searchController.clear();
    searchController.dispose();
    _posts.clear();
    scrollController.dispose();
    super.onClose();
  }

  /// refresh post data
  onRefresh() async {
    _posts.clear();
    page = 1;
    _getPosts();
  }

  /// onScroll event to load more data
  onScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        loadMore();
      }
    });
  }

  /// jump to top of listview
  srcollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
    );
  }

  /// jump to bottom of listview
  srcollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
    );
  }

  /// when user scroll down hide FAB
  onSrcollHideFAB() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _showFAB.value = false;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _showFAB.value = true;
      }
    });
  }

  /// get posts data from api
  Future<void> _getPosts() async {
    _loading.value = true;
    final result = await getPostsUsecases.call(page);
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

  /// load more data when user scroll down to the bottom
  Future<void> loadMore() async {
    EasyLoading.show(status: 'Loading more data...');
    try {
      final result = await getPostsUsecases.call(page);
      if (result.data != null && result.data!.isNotEmpty) {
        for (var element in result.data!) {
          _posts.add(element.toPostModel());
        }
      } else if (result.data!.isEmpty) {
        Get.snackbar(
          'Oops',
          'No more data to load',
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
        );
      } else {
        Get.snackbar(
          'Error',
          result.error!.error.toString(),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// navigate to post comment page with post id
  Future<void> getPostComment(int postId) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final result = await getPostCommentUsecase.call(postId);
      if (result.data != null && result.data!.isNotEmpty) {
        final List<CommentModel> list = [];
        for (var element in result.data!) {
          list.add(element.toCommentModel());
        }
        Get.to(
          () => PostCommentPage(
            comments: list,
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          result.error!.error.toString(),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// search for post query from api
  Future<void> searchForPost(String query) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final result = await searchForPostUseCase.call(query);
      if (result.data != null && result.data!.isNotEmpty) {
        _posts.clear();
        for (var element in result.data!) {
          _posts.add(element.toPostModel());
        }
      } else {
        Get.snackbar(
          'Error',
          'No data found with query: $query',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
