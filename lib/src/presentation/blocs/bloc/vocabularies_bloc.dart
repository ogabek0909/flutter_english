import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english/src/domain/models/vocabularies.dart';

part 'vocabularies_event.dart';
part 'vocabularies_state.dart';

class VocabulariesBloc extends Bloc<VocabulariesEvent, VocabulariesState> {
  VocabulariesBloc() : super(VocabulariesInitial()) {
    on<GetVocabularyEvent>(_onGetVocabulary);
  }

  void _onGetVocabulary(GetVocabularyEvent event, Emitter emit) async {
    //for spinner when waiting vocabulary
    emit(WaitingVocabulary());

    //getting data from firebase
    final response = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('vocabularies')
        .get();

    //assigning data which is from firebase to list of Vocabularies
    List<Vocabulary> _vocabularies = response.docs
        .map(
          (e) => Vocabulary(
            id: e.id,
            uzbek: e['uzbek'],
            definition: e['definition'],
            english: e['english'],
          ),
        )
        .toList();

    emit(GettedVocabulary(vocabularies: [..._vocabularies]));
  }
}
