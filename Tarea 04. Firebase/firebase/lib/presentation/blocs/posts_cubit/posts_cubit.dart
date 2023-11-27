import 'package:equatable/equatable.dart';
import 'package:firebase/infrasctructure/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(const PostsState());

  void getPosts(String collectionPath) {
    emit(state.copyWith(isLoading: true, posts: []));
    List<Map<String, dynamic>> posts = [];
    FirestoreService().getPosts(collectionPath).then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> documentData = element.data();
        documentData['id'] = element.id;
        posts.add(documentData);
      }
    }).then((value) {
      emit(state.copyWith(isLoading: false, posts: posts));
    });
  }

  Future<void> addPost(
      String collectionPath, String email, String message) async {
    await FirestoreService().addPost(collectionPath, email, message);
    getPosts(collectionPath);
  }

  void likePost(String collectionPath, String id, String email, bool isLiked) {
    FirestoreService().likePost(collectionPath, id, email, isLiked);
    getPosts(collectionPath);
  }
}
