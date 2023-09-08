import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english/src/presentation/views/auth_screen.dart';
import 'package:flutter_english/src/presentation/views/categories.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/auth',
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser != null) {
      return '/categories';
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/categories',
      name: CategoriesScreen.routeName,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: "/auth",
      name: AuthScreen.routeName,
      builder: (context, state) => const AuthScreen(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser!.isAnonymous) {
          return '/categories';
        }
      },
    ),
  ],
);
