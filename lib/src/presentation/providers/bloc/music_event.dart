part of 'music_bloc.dart';

sealed class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class StartMusic extends MusicEvent{
  final String musicPath;
  const StartMusic({required this.musicPath});
}
class PauseMusic extends MusicEvent{}
class PlayMusic extends MusicEvent{}
class StopMusic extends MusicEvent{}
class CompleteMusic extends MusicEvent{}
class MusicPlayingSlider extends MusicEvent{
  final int sliderPosition;
  const MusicPlayingSlider({required this.sliderPosition});
}