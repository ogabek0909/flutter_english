
import 'package:flutter/material.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/widgets/vocabulary_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RepeatingVocabulariesScreen extends StatelessWidget {
  const RepeatingVocabulariesScreen({super.key});
  static const routeName = 'repeating-vocabularies-screen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SelectionArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Repeat Your Vocabularies',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             children: [
               Text(
                 'vocabulary',
                 style: GoogleFonts.akshar(
                   fontSize: 30,
                 ),
               ),
               const SizedBox(height: 20),
                VocabularyCardWidget(),
             ],
           ),
            ),
        ),
      ),
    );
  }
}
