import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final String path;
  final void Function()? onTap;

  const CustomImageButton({
    super.key,
    required this.path,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.secondary,
          ),
          borderRadius: BorderRadius.circular(15),
          color: colors.secondaryContainer,
        ),
        child: Image.asset(
          path,
          height: 40,
        ),
      ),
    );
  }
}
