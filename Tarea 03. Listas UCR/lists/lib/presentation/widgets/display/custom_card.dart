import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? elevation;
  final String? title;
  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;
  final void Function()? onPressedView;

  const CustomCard({
    super.key,
    this.elevation,
    this.title,
    this.onPressedDelete,
    this.onPressedEdit,
    this.onPressedView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 30) / 2,
              child: Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton.filledTonal(
              onPressed: onPressedDelete,
              icon: const Icon(
                Icons.delete,
                size: 20,
              ),
            ),
            IconButton.filledTonal(
              onPressed: onPressedEdit,
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
            ),
            IconButton.filled(
              onPressed: onPressedView,
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
