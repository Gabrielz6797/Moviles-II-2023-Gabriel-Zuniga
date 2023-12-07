import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String fieldTitle;
  final String fieldData;
  final void Function()? onEditPressed;
  const CustomTextBox({
    super.key,
    required this.fieldTitle,
    required this.fieldData,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        top: 2,
        right: 15,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors.secondaryContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                fieldTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colors.secondary,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              IconButton(
                onPressed: onEditPressed,
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.white,
          ),
          Text(
            fieldData,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
