part of 'vocabularies_bloc.dart';

sealed class VocabulariesState extends Equatable {
  final List<Vocabulary> vocabularies;
  const VocabulariesState({required this.vocabularies});
  
  @override
  List<Object> get props => [];
}

final class VocabulariesInitial extends VocabulariesState {
  VocabulariesInitial():super(vocabularies: []);
}

final class GettedVocabulary extends VocabulariesState{
  const GettedVocabulary({required List<Vocabulary> vocabularies}):super(vocabularies: vocabularies);
}

final class WaitingVocabulary extends VocabulariesState{
  WaitingVocabulary():super(vocabularies: []);
}