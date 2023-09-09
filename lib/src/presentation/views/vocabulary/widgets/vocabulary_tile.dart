import 'package:flutter/material.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';

class VocabularyTileWidget extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyTileWidget({super.key, required this.vocabulary});

  @override
  State<VocabularyTileWidget> createState() => _VocabularyTileWidgetState();
}

class _VocabularyTileWidgetState extends State<VocabularyTileWidget> {
  bool isClicked = false;
  double? containerHieght;
  TextOverflow? textOverflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        height: containerHieght,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isClicked ? Colors.black12 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("En:  ${widget.vocabulary.english}"),
            Text(
              "Def: ${widget.vocabulary.definition.isEmpty ? widget.vocabulary.uzbek : widget.vocabulary.definition}",
              overflow: textOverflow,
            ),
            if (isClicked) Text("Uz: ${widget.vocabulary.uzbek}")
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