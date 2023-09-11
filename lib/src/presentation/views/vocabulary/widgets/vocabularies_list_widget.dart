import 'package:flutter/material.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/widgets/vocabulary_tile.dart';

class VocabulariesListWidget extends StatefulWidget {
  final List<Vocabulary> vocabularies;
  const VocabulariesListWidget({super.key, required this.vocabularies});

  @override
  State<VocabulariesListWidget> createState() => _VocabulariesListWidgetState();
}

class _VocabulariesListWidgetState extends State<VocabulariesListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: widget.vocabularies.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => SlideTransition(
          position:
              Tween(begin: const Offset(-.5, -.5), end: const Offset(0, 0))
                  .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.linear),
          ),
          child: child,
        ),
        child: VocabularyTileWidget(vocabulary: widget.vocabularies[index]),
      ),
    );
  }
}
