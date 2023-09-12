import 'package:flutter/material.dart';
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
                Container(
                  height: 350,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(-4, 6),
                      ),
                    ],
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'data',
                        style: GoogleFonts.akshar(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
