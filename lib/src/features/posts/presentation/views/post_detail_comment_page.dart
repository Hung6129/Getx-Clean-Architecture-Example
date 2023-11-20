import 'package:flutter/material.dart';

import 'package:get_example/src/features/posts/data/models/comment_model.dart';

class PostCommentPage extends StatelessWidget {
  const PostCommentPage({super.key, required this.comments});

  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments of Post ${comments[0].postId}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(comments[index].id.toString()),
            title: Text(comments[index].body),
            subtitle: Text('By: ${comments[index].email}'),
          );
        },
      ),
    );
  }
}
