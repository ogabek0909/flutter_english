import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  final String english;
  final String uzbek;
  final String definition;
  final String id;

  const Vocabulary({
    required this.id,
    required this.uzbek,
    required this.definition,
    required this.english,
  });

  @override
  List<Object?> get props => [english, uzbek, definition, id];
}
