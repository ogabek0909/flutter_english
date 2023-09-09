import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/config/routes.dart';
import 'package:flutter_english/src/config/themes.dart';
import 'package:flutter_english/src/presentation/blocs/bloc/vocabularies_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VocabulariesBloc(),
      child: MaterialApp.router(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
