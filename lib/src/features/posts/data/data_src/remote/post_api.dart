import 'dart:io';

import 'package:dio/dio.dart';

// https://jsonplaceholder.typicode.com/posts?_page=1&_limit=10

class PostApi {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    ),
  );

  Future<Response> getPosts(int page) async {
    final response = await dio.get('/posts?_page=$page&_limit=20');
    return response;
  }

  Future<Response> getComment(int id) async {
    final response = await dio.get('/posts/$id/comments');
    return response;
  }

  Future<Response> searchForPost(String query) async {
    final response = await dio.get('/posts?q=$query');
    return response;
  }
}
