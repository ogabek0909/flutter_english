import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/config/routes.dart';
import 'package:flutter_english/src/config/themes.dart';
import 'package:flutter_english/src/presentation/providers/bloc/vocabularies_bloc.dart';
import 'package:flutter_english/src/presentation/providers/cubit/index_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VocabulariesBloc()),
        BlocProvider(create: (context) => IndexCubit(),),
      ],
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
