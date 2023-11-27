import 'package:firebase/presentation/blocs.dart';
import 'package:firebase/presentation/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isAuth = context.read<AuthCubit>().state.isAuth;
    final isCreatingAccount = context.read<AuthCubit>().state.isCreatingAccount;

    if (!isAuth && !isCreatingAccount) {
      return '/login';
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
