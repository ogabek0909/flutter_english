import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english/src/domain/models/vocabulary.dart';
import 'package:flutter_english/src/utils/exceptions/firebase_exception.dart';

part 'vocabularies_event.dart';
part 'vocabularies_state.dart';

class VocabulariesBloc extends Bloc<VocabulariesEvent, VocabulariesState> {
  VocabulariesBloc() : super(VocabulariesInitial()) {
    on<GetVocabularyEvent>(_onGetVocabulary);
    on<AddVocabularyEvent>(_onAddVocabulary);
    on<DeleteVocabulary>(_onDeleteVocabulary);
    on<RepeatingVocabularyEvent>(_onGetRepeatingVocabulary);
  }

  void _onGetRepeatingVocabulary(RepeatingVocabularyEvent event, Emitter emit)async{
    final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('vocabularies')
          .orderBy('createdAt', descending: true)
          .get(const GetOptions(source: Source.cache));

    List<Vocabulary> _vocabularies = response.docs
          .map(
            (e) => Vocabulary(
              id: e.id,
              uzbek: e['uzbek'],
              definition: e['definition'],
              english: e['english'],
              createdAt: e['createdAt'],
            ),
          )
          .toList()..shuffle();

    emit(GetRepeatingVocabularyState(vocabularies: _vocabularies));
  }

  void _onDeleteVocabulary(DeleteVocabulary event, Emitter emit) async {
    emit(
      DeleteVocabularyState(
        vocabularies: state.vocabularies..remove(event.vocabulary),
      ),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('vocabularies')
        .doc(event.vocabulary.id)
        .delete();
  }

  void _onAddVocabulary(AddVocabularyEvent event, Emitter emit) async {
    emit(GettedVocabulary(
        vocabularies: state.vocabularies..add(event.vocabulary)));

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('vocabularies')
        .doc(event.vocabulary.id)
        .set(
      {
        "english": event.vocabulary.english,
        "uzbek": event.vocabulary.uzbek,
        "definition": event.vocabulary.definition,
        "createdAt": event.vocabulary.createdAt,
      },
    ).onError((error, stackTrace) {
      emit(GettedVocabulary(
          vocabularies: state.vocabularies..remove(event.vocabulary)));

      emit(ErrorState(message: error.toString()));
    });
  }

  void _onGetVocabulary(GetVocabularyEvent event, Emitter emit) async {
    //for spinner when waiting vocabulary

    emit(WaitingVocabulary());

    List<Vocabulary> _vocabularies = [];

    //getting data from firebase

    try {
      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('vocabularies')
          .orderBy('createdAt', descending: true)
          .get();
      //assigning data which is from firebase to list of Vocabularies
      _vocabularies = response.docs
          .map(
            (e) => Vocabulary(
              id: e.id,
              uzbek: e['uzbek'],
              definition: e['definition'],
              english: e['english'],
              createdAt: e['createdAt'],
            ),
          )
          .toList();
    } on CustomFirebaseException catch (error) {
      emit(ErrorState(message: error.message ?? "Something went wrong!"));

      // ScaffoldMessenger.of(event.context).showSnackBar(
      //   SnackBar(
      //     content: Text(error.message ?? "Something went wrong!"),
      //   ),
      // );
    }

    emit(GettedVocabulary(vocabularies: [..._vocabularies]));
  }
}
