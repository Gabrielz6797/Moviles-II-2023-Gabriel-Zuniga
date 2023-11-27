import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: colors.secondary,
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            color: colors.primary,
            width: 2,
          ),
        ),
        isDense: true,
        fillColor: colors.secondaryContainer.withAlpha(100),
        filled: true,
      ),
      obscureText: obscureText,
    );
  }
}
