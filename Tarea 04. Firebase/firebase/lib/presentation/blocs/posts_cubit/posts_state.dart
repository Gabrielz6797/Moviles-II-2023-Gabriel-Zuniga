part of 'posts_cubit.dart';

class PostsState extends Equatable {
  final bool isLoading;
  final List<Map<String, dynamic>> posts;

  const PostsState({
    this.isLoading = false,
    this.posts = const [],
  });

  PostsState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? posts,
  }) =>
      PostsState(
        isLoading: isLoading ?? this.isLoading,
        posts: posts ?? this.posts,
      );

  @override
  List<Object> get props => [isLoading, posts];
}
