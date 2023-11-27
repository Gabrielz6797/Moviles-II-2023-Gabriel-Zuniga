import 'package:firebase/presentation/blocs.dart';
import 'package:firebase/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPost extends StatefulWidget {
  final String user;
  final String message;
  final String postId;
  final List<String> likes;
  final String collectionPath;

  const CustomPost({
    super.key,
    required this.user,
    required this.message,
    required this.postId,
    required this.likes,
    required this.collectionPath,
  });

  @override
  State<CustomPost> createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  bool isLiked = false;
  late String currentEmail;
  int numberOfLikes = 0;

  @override
  void initState() {
    super.initState();
    currentEmail = context.read<AuthCubit>().state.email;
    isLiked = widget.likes.contains(currentEmail);
    numberOfLikes = widget.likes.length;
  }

  void toggleLike(
    PostsCubit postsCubit,
    String id,
  ) {
    setState(
      () {
        isLiked = !isLiked;
        numberOfLikes = isLiked ? numberOfLikes + 1 : numberOfLikes - 1;
        postsCubit.likePost(
          widget.collectionPath,
          widget.postId,
          currentEmail,
          isLiked,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final postsCubit = context.read<PostsCubit>();

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: colors.secondaryContainer,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: colors.onPrimary,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  style: TextStyle(
                    color: colors.primary.withAlpha(200),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.message,
                  style: TextStyle(
                    color: colors.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          CustomLikeButton(
            onTap: () => toggleLike(
              postsCubit,
              widget.postId,
            ),
            isLiked: isLiked,
            numberOfLikes: numberOfLikes.toString(),
          ),
        ],
      ),
    );
  }
}
