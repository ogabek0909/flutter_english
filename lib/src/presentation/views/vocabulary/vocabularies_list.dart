import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/new_vocabulary_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Vocabularies"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('vocabularies')
              .get(),
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
              return VocabulariesListWidget(
                vocabularies: snapshot.data!.docs
                    .map((e) => Vocabulary(
                          id: e.id,
                          uzbek: e['uzbek'],
                          definition: e['definition'],
                          english: e['english'],
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
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
