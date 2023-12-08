import 'package:space_battles/presentation/blocs.dart';
import 'package:space_battles/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void editFieldDialog(
    String text,
    AuthCubit authCubit,
    String field,
    String email,
  ) {
    String newValue = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit $text',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Edit your $text',
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FilledButton(
              onPressed: () {
                if (newValue != '') {
                  authCubit.updateUserData(
                    email,
                    field,
                    newValue,
                  );
                }
                context.pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final email = context.watch<AuthCubit>().state.email;
    final username = context.watch<AuthCubit>().state.username;
    final score = context.watch<AuthCubit>().state.score;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: email != ''
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 40, color: colors.primary),
                          ],
                        ),
                      ),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.secondary, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About me',
                        style: TextStyle(color: colors.secondary, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextBox(
                        fieldTitle: 'Username:',
                        fieldData: username,
                        editable: true,
                        image: false,
                        onEditPressed: () {
                          editFieldDialog(
                            'username',
                            authCubit,
                            'username',
                            email,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextBox(
                        fieldTitle: 'High score:',
                        fieldData: score.toString(),
                        editable: false,
                        image: false,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: MediaQuery.of(context).size.height / 16,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/main-menu');
                          },
                          child: const Text(
                            'Home',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not logged in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 40, color: colors.primary),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: MediaQuery.of(context).size.height / 16,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: MediaQuery.of(context).size.height / 16,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/main-menu');
                          },
                          child: const Text(
                            'Home',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
