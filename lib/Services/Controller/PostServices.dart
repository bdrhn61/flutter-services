import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Models/CommentModel.dart';
import 'I_PostServices.dart';
import '../Models/PostModel.dart';

class PostServis implements IPostServices {
  final Dio _dio; // burası late tanımlı idi
  PostServis()
      : _dio = Dio(BaseOptions(
            baseUrl:
                'https://jsonplaceholder.typicode.com/')); // late kullanmamak için bunu yaptık

  @override
  Future<bool> addItemToService(Map<String, dynamic> model) async {
    try {
      final response =
          await _dio.post(_PostServicePaths.posts.name, data: model);
      return response.statusCode == HttpStatus.created;
    } on DioException catch (error) {
      ShowDebug.showDioError(error);
    }
    return false;
  }

  @override
  Future<bool> putItemToService(Map<String, dynamic> model, int id) async {
    try {
      final response =
          await _dio.put('${_PostServicePaths.posts.name}/$id', data: model);

      return response.statusCode == HttpStatus.ok;
    } on DioException catch (error) {
      ShowDebug.showDioError(error);
    }
    return false;
  }

  @override
  Future<bool> deleteItemToService(Map<String, dynamic> model, int id) async {
    try {
      final response = await _dio.delete('$id');

      return response.statusCode == HttpStatus.ok;
    } on DioException catch (error) {
      ShowDebug.showDioError(error);
    }
    return false;
  }

  @override
  Future<List<PostModel>?> fetchPostItemAdvence() async {
    try {
      final response = await _dio.get(_PostServicePaths.posts.name);
      if (response.statusCode == HttpStatus.ok) {
        final dates = response.data;
        if (dates is List) {
          return dates.map((e) => PostModel.fromJson(e)).toList();
        }
      } else {
        return null;
      }
    } on DioException catch (error) {
      ShowDebug.showDioError(error);
    }
    return null;
  }

  @override
  Future<List<CommentModel>?> fetchRelatedCommntsWithPostId(int postId) async {
    try {
      final response = await _dio.get(_PostServicePaths.comments.name,
          queryParameters: {
            _PostServiceQueryParametersPaths.postId.name: postId
          });
      if (response.statusCode == HttpStatus.ok) {
        final dates = response.data;
        if (dates is List) {
          return dates.map((e) => CommentModel.fromJson(e)).toList();
        }
      } else {
        return null;
      }
    } on DioException catch (error) {
      ShowDebug.showDioError(error);
    }
    return null;
  }
}

enum _PostServicePaths { posts, comments }

enum _PostServiceQueryParametersPaths { postId }

class ShowDebug {
  static void showDioError(DioException error) {
    if (kDebugMode) {
      print(error.message);
    }
  }
}
