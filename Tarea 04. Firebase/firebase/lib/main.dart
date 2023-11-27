import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/config/router/app_router.dart';
import 'package:firebase/config/theme/app_theme.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/presentation/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => PostsCubit(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      routerConfig: appRouter,
    );
  }
}
