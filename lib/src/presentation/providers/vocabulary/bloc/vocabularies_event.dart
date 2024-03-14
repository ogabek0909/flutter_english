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
  final BuildContext context;
  final Vocabulary vocabulary;
  const AddVocabularyEvent({required this.vocabulary, required this.context});
}

class DeleteVocabulary extends VocabulariesEvent {
  final Vocabulary vocabulary;
  const DeleteVocabulary({required this.vocabulary});
}

class RepeatingVocabularyEvent extends VocabulariesEvent {}
