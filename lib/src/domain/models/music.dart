import 'package:equatable/equatable.dart';

class Music extends Equatable{
  final String path;
  final String? title;
  final String? artist;

  const Music({required this.path,  this.title,  this.artist});

  @override
  // TODO: implement props
  List<Object?> get props => [path, artist,title];
}