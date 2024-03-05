import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/data/local/musics.dart';
import 'package:flutter_english/src/domain/models/music.dart';
import 'package:flutter_english/src/presentation/providers/bloc/music_bloc.dart';
import 'package:flutter_english/src/presentation/views/music/music_detail_screen.dart';
import 'package:go_router/go_router.dart';


class MusicListScreen extends StatefulWidget {
  const MusicListScreen({super.key});
  static const routeName = 'music-list-screen';

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  void play(Music music, MusicState state) async {
    if(state is MusicInitial || state is MusicPaused || state is MusicPlaying){
      
      BlocProvider.of<MusicBloc>(context).add(StartMusic(musicPath: music.path));
      
    }
    context.goNamed(MusicDetailScreen.routeName, extra: music);
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BlocProvider.of<MusicBloc>(context).add(StopMusic());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My English Musics"),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: musicsList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => play(musicsList[index], state),
              leading: const Icon(Icons.music_note),
              title: Text(musicsList[index].title ?? "Unknown"),
              subtitle: Text(musicsList[index].artist ?? "Unknown"),
              trailing: IconButton(
                onPressed: () => play(musicsList[index], state),
                icon: Icon(state is MusicPlaying ? Icons.pause : Icons.play_arrow),
              ),
            ),
          );
        },
      ),
    );
  }
}
