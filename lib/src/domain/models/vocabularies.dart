import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  final String english;
  final String uzbek;
  final String definition;
  final String id;
  final Timestamp createdAt;

  const Vocabulary({
    required this.id,
    required this.uzbek,
    required this.definition,
    required this.english,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [english, uzbek, definition, id,createdAt];
}
