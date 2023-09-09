part of 'vocabularies_bloc.dart';

sealed class VocabulariesEvent extends Equatable {
  const VocabulariesEvent();

  @override
  List<Object> get props => [];
}

class GetVocabularyEvent extends VocabulariesEvent {}
