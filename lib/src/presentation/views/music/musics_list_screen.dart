import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/data/local/musics.dart';
import 'package:flutter_english/src/domain/models/music.dart';
import 'package:flutter_english/src/presentation/providers/music/bloc/music_bloc.dart';
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
  // bool isPlaying = false;
  int currentPlayingIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  void play(Music music, MusicState state) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/result.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("My English Musics"),
          backgroundColor: Colors.black45,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemCount: musicsList.length,
          itemBuilder: (context, index) => BlocBuilder<MusicBloc, MusicState>(
            builder: (context, state) {
              return ListTile(
                tileColor: Colors.white54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  BlocProvider.of<MusicBloc>(context).add(
                    StartMusic(musicPath: musicsList[index].path),
                  );

                  context.goNamed(MusicDetailScreen.routeName,
                      extra: musicsList[index]);
                },
                leading: const Icon(Icons.music_note),
                title: Text(musicsList[index].title ?? "Unknown"),
                subtitle: Text(musicsList[index].artist ?? "Unknown"),
                trailing: IconButton(
                  onPressed: () {
                    if (index == currentPlayingIndex) {
                      setState(() {
                        currentPlayingIndex =
                            -1; // Reset currently playing index
                      });
                    } else {
                      setState(() {
                        currentPlayingIndex =
                            index; // Update currently playing index
                      });
                    }
                    if (state is MusicPlaying) {
                      BlocProvider.of<MusicBloc>(context).add(
                        PauseMusic(),
                      );
                    } else if (state is MusicPaused) {
                      BlocProvider.of<MusicBloc>(context).add(
                        PlayMusic(),
                      );
                    } else {
                      BlocProvider.of<MusicBloc>(context).add(
                        StartMusic(musicPath: musicsList[index].path),
                      );
                    }
                  },
                  icon: Icon(currentPlayingIndex == index
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
