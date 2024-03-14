import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/domain/models/result_vocabulary.dart';
import 'package:flutter_english/src/presentation/providers/vocabulary/bloc/vocabularies_bloc.dart';
import 'package:flutter_english/src/presentation/providers/vocabulary/cubit/index_cubit.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/result_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


class VocabularyCardWidget extends StatefulWidget {
  // final Vocabulary vocabulary;
  const VocabularyCardWidget({
    super.key,
    // required this.vocabulary,
  });

  @override
  State<VocabularyCardWidget> createState() => _VocabularyCardWidgetState();
}

class _VocabularyCardWidgetState extends State<VocabularyCardWidget> {
  int vocabularyIndex = 0;
  final FlipCardController _cardController = FlipCardController();
  final List<ResultVocabulary> _resultVocabulary = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VocabulariesBloc>(context).add(RepeatingVocabularyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabulariesBloc, VocabulariesState>(
      builder: (context, state) => BlocBuilder<IndexCubit, IndexState>(
        builder: (context, indexState) => FlipCard(
          controller: _cardController,
          back: Container(
            height: 350,
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(4, 6),
                ),
              ],
              color: Colors.blueAccent[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'TRANSLATION',
                  style: GoogleFonts.akshar(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 4,
                        color: Colors.yellow[100],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      state.vocabularies[indexState.index].uzbek,
                      style: GoogleFonts.akshar(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(247, 210, 128, 6),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _resultVocabulary.add(ResultVocabulary(vocabularies: state.vocabularies[indexState.index], isTrue: false,),);
                        
                        _cardController.toggleCardWithoutAnimation();
                        if (indexState.index == state.vocabularies.length - 1) {
                          context.goNamed(
                            ResultScreen.routeName,
                            extra: _resultVocabulary,
                          );
                        } else {
                          BlocProvider.of<IndexCubit>(context).increment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 40)),
                      child: const Text('I don\'t know'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                        _resultVocabulary.add(ResultVocabulary(vocabularies: state.vocabularies[indexState.index], isTrue: true,),);
                        _cardController.toggleCardWithoutAnimation();
                        if (indexState.index == state.vocabularies.length - 1) {
                          context.goNamed(
                            ResultScreen.routeName,
                            extra: _resultVocabulary,
                          );
                        } else {
                          BlocProvider.of<IndexCubit>(context).increment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 40)),
                      child: const Text('I know'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          front: Container(
            height: 350,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-4, 6),
                ),
              ],
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'WORD',
                    style: GoogleFonts.akshar(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 4,
                          color: Colors.yellow[100],
                        ),
                      )
                    ],
                  ),
                  Text(
                    state.vocabularies[indexState.index].english,
                    style: GoogleFonts.akshar(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo[100],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.vocabularies[indexState.index].definition,
                    style: GoogleFonts.alice(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo[100],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
