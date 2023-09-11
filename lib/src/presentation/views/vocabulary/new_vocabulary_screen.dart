import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';
import 'package:flutter_english/src/presentation/blocs/bloc/vocabularies_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

enum Language {
  english,
  uzbek,
}

class NewVocabularyScreen extends StatefulWidget {
  const NewVocabularyScreen({super.key});
  static const routeName = 'new-vocabulary-screen';

  @override
  State<NewVocabularyScreen> createState() => _NewVocabularyScreenState();
}

class _NewVocabularyScreenState extends State<NewVocabularyScreen> {
  final TextEditingController _english = TextEditingController();
  final TextEditingController _uzbek = TextEditingController();
  final TextEditingController _definition = TextEditingController();
  Language _language = Language.english;
  var uuid = const Uuid();
  void _onAdd() async {
    if (_english.text.isEmpty || _uzbek.text.isEmpty) {
      return;
    }

    Vocabulary _vocabulary = Vocabulary(
      id: uuid.v1(),
      uzbek: _uzbek.text,
      definition: _definition.text,
      english: _english.text,
      createdAt: Timestamp.now(),
    );

    BlocProvider.of<VocabulariesBloc>(context)
        .add(AddVocabularyEvent(vocabulary: _vocabulary, context: context));
    _english.clear();
    _uzbek.clear();
    _definition.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text('New Vocabulary'),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  if (_language == Language.uzbek) {
                    setState(() {
                      _language = Language.english;
                    });
                  } else {
                    setState(() {
                      _language = Language.uzbek;
                    });
                  }
                });
              },
              child: Row(
                children: [
                  Text(
                    _language == Language.english ? ' 🇬🇧 ' : " 🇺🇿 ",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Icon(Icons.sync_alt_outlined, size: 18),
                  Text(
                    _language == Language.english ? " 🇺🇿 " : ' 🇬🇧 ',
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _language == Language.english ? ' English' : " Uzbek",
                  style: GoogleFonts.foldit(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _english,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white60,
                          filled: true,
                          hintText: 'Word*',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  ' Definition',
                  style: GoogleFonts.foldit(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 5,
                        controller: _definition,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white60,
                          filled: true,
                          hintText: 'Definition (optional)',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _language == Language.english ? ' Uzbek' : " English",
                  style: GoogleFonts.foldit(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _uzbek,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white60,
                          filled: true,
                          hintText: 'Translation*',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                ElevatedButton(
                  onPressed: _onAdd,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text(
                    'Add To The Vocabularies',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
