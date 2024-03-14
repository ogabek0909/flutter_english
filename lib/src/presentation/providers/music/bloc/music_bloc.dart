

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;

  MusicBloc() : super(MusicInitial()) {
    on<StartMusic>(_onStart);
    on<PauseMusic>(_onPause);
    on<PlayMusic>(_onPlay);
    on<StopMusic>(_onStop);
    on<CompleteMusic>(_onComplete);
    on<MusicPlayingSlider>(_onSlide);
  }


  void _onStart(StartMusic event, Emitter emit) async{
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('music/' + event.musicPath));
    _playerState = PlayerState.playing;
    int currentPosition = (await _audioPlayer.getCurrentPosition())!.inSeconds;


    emit(MusicPlaying(currentPosition: currentPosition,maxDuration: (await _audioPlayer.getDuration())!.inSeconds,),);
    print('started');
  }

  void _onPause(PauseMusic event, Emitter emit) async{
    if(_playerState == PlayerState.playing){
      await _audioPlayer.pause();
      _playerState = PlayerState.paused;
      int currentPosition = (await _audioPlayer.getCurrentPosition())!.inSeconds;
      emit(MusicPaused(currentPosition: currentPosition,maxDuration: (await _audioPlayer.getDuration())!.inSeconds,),);
      print('paused');
    }
  }

  void _onPlay(PlayMusic event, Emitter emit) async{
    if(_playerState == PlayerState.paused){
      await _audioPlayer.resume();
      _playerState = PlayerState.playing;
      int currentPosition = (await _audioPlayer.getCurrentPosition())!.inSeconds;
      emit(MusicPlaying(currentPosition: currentPosition, maxDuration: (await _audioPlayer.getDuration())!.inSeconds,),);
      print('played');
    }
  }

  void _onStop(StopMusic event, Emitter emit)async{
    if(_playerState == PlayerState.playing || _playerState == PlayerState.paused){
     await  _audioPlayer.stop();
     _playerState = PlayerState.stopped;
     emit(MusicStopped());
     print('stopped');
    }
  }

  void _onComplete(CompleteMusic event, Emitter emit)async{
    _playerState = PlayerState.completed;
    await _audioPlayer.stop();
    emit(MusicCompleted());
  }

  void _onSlide(MusicPlayingSlider event, Emitter emit)async{
    await _audioPlayer.seek(Duration(seconds:event.sliderPosition));
    emit(MusicPlaying(currentPosition: event.sliderPosition, maxDuration: (await _audioPlayer.getDuration())!.inSeconds));
  }
}
