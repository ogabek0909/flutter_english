import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english/src/presentation/views/auth_screen.dart';
import 'package:flutter_english/src/presentation/views/categories_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/new_vocabulary_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/repeating_vocabularies_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/vocabularies_list_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/categories',
      name: CategoriesScreen.routeName,
      builder: (context, state) => const CategoriesScreen(),
      routes: [
        GoRoute(
          path: 'vocabularisList',
          name: VocabulariesListScreen.routeName,
          builder: (context, state) => const VocabulariesListScreen(),
          routes: [
            GoRoute(
              path: 'newVocabulary',
              name: NewVocabularyScreen.routeName,
              builder: (context, state) => const NewVocabularyScreen(),
            ),
            GoRoute(
              path: 'repeatingVocabulary',
              name: RepeatingVocabulariesScreen.routeName,
              builder: (context, state) => const RepeatingVocabulariesScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/auth",
      name: AuthScreen.routeName,
      builder: (context, state) => const AuthScreen(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return '/categories';
        } else {
          return null;
        }
      },
    ),
  ],
);
