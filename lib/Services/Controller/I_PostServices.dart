
import '../Models/CommentModel.dart';
import '../Models/PostModel.dart';

abstract class IPostServices {
  Future<bool> addItemToService(Map<String, dynamic> model);
  Future<bool> putItemToService(Map<String, dynamic> model, int id) ;
  Future<bool> deleteItemToService(Map<String, dynamic> model, int id);
  Future<List<PostModel>?> fetchPostItemAdvence();
  Future<List<CommentModel>?> fetchRelatedCommntsWithPostId(int postId);

}