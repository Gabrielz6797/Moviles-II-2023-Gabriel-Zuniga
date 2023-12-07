import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String fieldTitle;
  final String fieldData;
  final bool editable;
  final void Function()? onEditPressed;
  const CustomTextBox({
    super.key,
    required this.fieldTitle,
    required this.fieldData,
    required this.editable,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
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
              editable
                  ? GestureDetector(
                      onTap: () {
                        onEditPressed!();
                      },
                      child: const Icon(
                        Icons.edit_rounded,
                        size: 24,
                      ),
                    )
                  : const Text(''),
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
