import 'package:go_router/go_router.dart';
import 'package:lists/presentation/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-professor',
      builder: (context, state) => const ProfessorAddModifyScreen(),
    ),
    GoRoute(
      path: '/modify-professor/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return ProfessorAddModifyScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/professor/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return ProfessorDetailsScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/add-course',
      builder: (context, state) => const CourseAddModifyScreen(),
    ),
    GoRoute(
      path: '/modify-course/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return CourseAddModifyScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/course/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return CourseDetailsScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/add-student',
      builder: (context, state) => const StudentAddModifyScreen(),
    ),
    GoRoute(
      path: '/modify-student/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return StudentAddModifyScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/student/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return StudentDetailsScreen(
          id: id,
        );
      },
    ),
  ],
);
