part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

final class MusicInitial extends MusicState {}

 class MusicPlaying extends MusicState {
  final int currentPosition;
  final int maxDuration;

  const MusicPlaying({required this.currentPosition, required this.maxDuration});

  @override
  // TODO: implement props
  List<Object> get props => [currentPosition, maxDuration];
}

final class MusicStopped extends MusicState {}

 class MusicPaused extends MusicState {
  final int currentPosition;
  final int maxDuration;

  const MusicPaused({required this.currentPosition, required this.maxDuration});

  @override
  // TODO: implement props
  List<Object> get props => [currentPosition, maxDuration];
}

final class MusicCompleted extends MusicState {}


