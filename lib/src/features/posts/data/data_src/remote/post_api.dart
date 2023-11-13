import 'dart:io';

import 'package:dio/dio.dart';

class PostApi {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  ));

  Future<Response> getPosts() async {
    final response = await dio.get('/posts');
    return response;
  }

  Future<Response> getComment(int id) async {
    final response = await dio.get('posts/$id/comments');
    return response;
  }
}
