import 'package:space_battles/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:space_battles/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [RegisterScreen] Allows the player to create an account
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp(BuildContext context, AuthCubit authCubit) async {
    if (_confirmPasswordController.text == _passwordController.text) {
      authCubit
          .signUpUser(_emailController.text, _passwordController.text)
          .then(
        (value) {
          if (authCubit.state.error) {
            showDialog(
              context: context,
              builder: (context) {
                String e = authCubit.state.errorMessage;
                authCubit.isCreatingAccount();
                authCubit.reset();
                return AlertDialog(
                  title: Text(e),
                );
              },
            );
          } else {
            context.go('/main-menu');
          }
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          authCubit.reset();
          return const AlertDialog(
            title: Text("The passwords don't match"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authCubit = context.watch<AuthCubit>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 40, color: colors.primary),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintText: 'Confirm password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: MediaQuery.of(context).size.height / 16,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp(context, authCubit);
                    },
                    child: const Text(
                      'Register',
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
                      'Cancel',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: colors.secondary,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authCubit.isCreatingAccount();
                    context.go('/login');
                  },
                  child: Text(
                    'Login!',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
