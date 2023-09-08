
import 'package:flutter_english/src/presentation/views/auth_screen.dart';
import 'package:flutter_english/src/presentation/views/categories.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: CategoriesScreen.routeName,
      builder: (context, state) =>const CategoriesScreen(),
    ),
    GoRoute(path: "/auth",
    name: AuthScreen.routeName,
    builder: (context, state) => const AuthScreen(),

    ),
  ],
);
