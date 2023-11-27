import 'package:firebase/presentation/widgets.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final void Function()? onHomeTap;
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;
  const CustomDrawer({
    super.key,
    required this.onHomeTap,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colors.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.person,
              size: 70,
              color: colors.primary,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomListTile(
            icon: Icons.home_rounded,
            title: 'I N I C I O',
            onTap: onHomeTap,
          ),
          CustomListTile(
            icon: Icons.person_rounded,
            title: 'P E R F I L',
            onTap: onProfileTap,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          CustomListTile(
            icon: Icons.logout_rounded,
            title: 'S A L I R',
            onTap: onLogoutTap,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
