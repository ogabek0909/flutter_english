import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/domain/models/vocabulary.dart';
import 'package:flutter_english/src/presentation/providers/vocabulary/bloc/vocabularies_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyTileWidget extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyTileWidget({super.key, required this.vocabulary});

  @override
  State<VocabularyTileWidget> createState() => _VocabularyTileWidgetState();
}

class _VocabularyTileWidgetState extends State<VocabularyTileWidget> {
  bool isClicked = false;
  TextOverflow? textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => SizedBox(
            width: 100,
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(10),
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    trailing: const Icon(Icons.delete),
                    title: const Text("Delete"),
                    onTap: () {
                      BlocProvider.of<VocabulariesBloc>(context).add(
                        DeleteVocabulary(vocabulary: widget.vocabulary),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    onTap: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This screen doesn't exist"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    title: Text('Edit'),
                    trailing: Icon(Icons.edit),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                )
              ],
            ),
          ),
        );
      },
      onTap: () {
        setState(() {
          isClicked = !isClicked;
          if (isClicked) {
            textOverflow = null;
          } else {
            textOverflow = TextOverflow.ellipsis;
          }
        });
      },
      child: Container(
        height: !isClicked ? 50 : null,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isClicked
              ? Colors.grey.withOpacity(.8)
              : Colors.white.withOpacity(.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "En:  ${widget.vocabulary.english}",
              overflow: textOverflow,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "Def: ${widget.vocabulary.definition.isEmpty ? widget.vocabulary.uzbek : widget.vocabulary.definition}",
              overflow: textOverflow,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
              ),
            ),
            if (isClicked)
              Text(
                "Uz: ${widget.vocabulary.uzbek}",
                overflow: textOverflow,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.normal,
                ),
              )
          ],
        ),
      ),
    );
  }
}
/*
 ListTile(
      key: UniqueKey(),
      title: Text(vocabulary.english),
      subtitle: Text(
        vocabulary.definition.isEmpty
            ? vocabulary.uzbek
            : vocabulary.definition,
      ),
      tileColor: Colors.amber,
      onLongPress: () {
        print("Do you want to delete this vocabulary");
      },
    )
    */