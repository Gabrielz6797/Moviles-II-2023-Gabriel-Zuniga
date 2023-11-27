import 'package:firebase/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:firebase/presentation/widgets.dart';
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
          context.go('/');
        }
      },
    );
  }

  void signInGoogle(BuildContext context, AuthCubit authCubit) async {
    authCubit.signInGoogleUser().then(
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
          context.go('/');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authCubit = context.watch<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresar'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Icon(
                    Icons.android_rounded,
                    color: colors.primary,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bienvenido de vuelta!',
                        style: TextStyle(
                          color: colors.secondary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    hintText: 'Correo',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hintText: 'Contraseña',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    title: 'Ingresar',
                    onTap: () => signIn(
                      context,
                      authCubit,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colors.secondaryContainer,
                          thickness: 0.5,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'O ingresa con:',
                        style: TextStyle(
                          color: colors.secondary,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Divider(
                          color: colors.secondaryContainer,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageButton(
                        path: 'lib/assets/images/google.png',
                        onTap: () => signInGoogle(
                          context,
                          authCubit,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No eres miembro?',
                        style: TextStyle(
                          color: colors.secondary,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          authCubit.isCreatingAccount();
                          context.go('/register');
                        },
                        child: Text(
                          ' Regístrate ya!',
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
