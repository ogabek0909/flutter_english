part of 'vocabularies_bloc.dart';

sealed class VocabulariesEvent extends Equatable {
  const VocabulariesEvent();

  @override
  List<Object> get props => [];
}

class GetVocabularyEvent extends VocabulariesEvent {
  final BuildContext context;
  const GetVocabularyEvent({required this.context});
}

class AddVocabularyEvent extends VocabulariesEvent {
  BuildContext context;
  final Vocabulary vocabulary;
  AddVocabularyEvent({required this.vocabulary,required this.context});
}
