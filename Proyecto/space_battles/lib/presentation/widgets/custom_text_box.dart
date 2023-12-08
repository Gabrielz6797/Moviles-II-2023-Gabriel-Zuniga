import 'package:flutter/material.dart';
import 'package:space_battles/models/spaceship.dart';

class CustomTextBox extends StatelessWidget {
  final String fieldTitle;
  final String fieldData;
  final bool editable;
  final bool image;
  final void Function()? onEditPressed;
  const CustomTextBox({
    super.key,
    required this.fieldTitle,
    required this.fieldData,
    required this.editable,
    required this.image,
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
            thickness: 0.2,
            indent: 0,
            endIndent: 0,
            color: Colors.white,
          ),
          image
              ? Image.asset(
                  Spaceship.spaceships[int.parse(fieldData)].assetPath,
                  width: 72,
                  height: 72,
                )
              : Text(
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
