import 'package:flutter/material.dart';

class CustomLikeButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isLiked;
  final String numberOfLikes;

  const CustomLikeButton({
    super.key,
    required this.onTap,
    required this.isLiked,
    required this.numberOfLikes,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? colors.primary : colors.secondaryContainer,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          numberOfLikes,
        ),
      ],
    );
  }
}
