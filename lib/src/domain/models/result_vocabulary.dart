import 'package:equatable/equatable.dart';

import './vocabulary.dart';

class ResultVocabulary extends Equatable{
  final Vocabulary vocabularies;
  final bool isTrue;
  const ResultVocabulary({required this.vocabularies, required this.isTrue});

  @override
  // TODO: implement props
  List<Object?> get props => [vocabularies, isTrue];
}