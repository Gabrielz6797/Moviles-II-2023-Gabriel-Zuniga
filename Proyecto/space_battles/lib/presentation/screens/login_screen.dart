import 'package:space_battles/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:space_battles/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIn(BuildContext context, AuthCubit authCubit) async {
    authCubit.signInUser(_emailController.text, _passwordController.text).then(
      (value) {
        if (authCubit.state.error) {
          showDialog(
            context: context,
            builder: (context) {
              String e = authCubit.state.errorMessage;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 40, color: colors.primary),
                    ],
                  ),
                ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 16,
                child: ElevatedButton(
                  onPressed: () {
                    signIn(context, authCubit);
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
                width: MediaQuery.of(context).size.width / 2,
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
                "Don't have an account?",
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  authCubit.isCreatingAccount();
                  context.go('/register');
                },
                child: Text(
                  'Register!',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
