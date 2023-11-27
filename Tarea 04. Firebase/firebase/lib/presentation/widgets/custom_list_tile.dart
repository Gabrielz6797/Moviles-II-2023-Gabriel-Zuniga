import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: colors.secondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.secondary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
