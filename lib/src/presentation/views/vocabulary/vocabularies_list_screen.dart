import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/domain/models/vocabulary.dart';
import 'package:flutter_english/src/presentation/providers/vocabulary/bloc/vocabularies_bloc.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/new_vocabulary_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/repeating_vocabularies_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/widgets/vocabularies_list_widget.dart';
import 'package:go_router/go_router.dart';

class VocabulariesListScreen extends StatefulWidget {
  const VocabulariesListScreen({super.key});
  static const routeName = 'vocabularies-list';

  @override
  State<VocabulariesListScreen> createState() => _VocabulariesListScreenState();
}

class _VocabulariesListScreenState extends State<VocabulariesListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VocabulariesBloc>(context)
        .add(GetVocabularyEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/astronomy.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text(
            "Your Vocabularies",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                context.goNamed(RepeatingVocabulariesScreen.routeName);
              },
              icon: const Icon(Icons.view_timeline_outlined),
              label: const Text('Repeat'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
          child: BlocBuilder<VocabulariesBloc, VocabulariesState>(
            builder: (context, state) {
              if (state is WaitingVocabulary) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return VocabulariesListWidget(
                  vocabularies: state.vocabularies
                      .map((e) => Vocabulary(
                            id: e.id,
                            uzbek: e.uzbek,
                            definition: e.definition,
                            english: e.english,
                            createdAt: e.createdAt,
                          ))
                      .toList(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // context.goNamed(NewVocabularyScreen.routeName);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewVocabularyScreen(),
                )).then((value) {
              setState(() {});
            });
          },
          backgroundColor: Colors.white.withOpacity(.7),
          child: const Icon(
            Icons.add,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
/*
FutureBuilder(
          future: ,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return BlocBuilder(
                builder:(context, state) => VocabulariesListWidget(
                  vocabularies: snapshot.data!.docs
                      .map((e) => Vocabulary(
                            id: e.id,
                            uzbek: e['uzbek'],
                            definition: e['definition'],
                            english: e['english'],
                          ))
                      .toList(),
                ),
              );
            }
          },
        ),

*/