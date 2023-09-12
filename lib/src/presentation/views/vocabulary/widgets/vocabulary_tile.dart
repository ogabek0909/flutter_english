import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';
import 'package:flutter_english/src/presentation/providers/bloc/vocabularies_bloc.dart';

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
                    trailing:const Icon(Icons.delete),
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