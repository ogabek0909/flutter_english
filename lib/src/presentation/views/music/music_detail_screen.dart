import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_english/src/presentation/providers/music/bloc/music_bloc.dart';

import '../../../domain/models/music.dart';

class MusicDetailScreen extends StatelessWidget {
  final Music music;
  const MusicDetailScreen({super.key, required this.music});
  static const routeName = 'music-detail-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/music_background.avif'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('English Music Player'),
        ),
        body: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    height: 350,
                    // width: 300,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/nature.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Text(
                  music.title ?? "Unknown Title",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  music.artist ?? "Unknown Artist",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                if (state is MusicPlaying)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Slider(
                      value: state.currentPosition.toDouble(),
                      max: state.maxDuration.toDouble(),
                      onChanged: (value) {
                        BlocProvider.of<MusicBloc>(context).add(
                            MusicPlayingSlider(sliderPosition: value.toInt()));
                      },
                    ),
                  ),
                if (state is MusicPaused)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Slider(
                      value: state.currentPosition.toDouble(),
                      max: state.maxDuration.toDouble(),
                      onChanged: (value) {
                        BlocProvider.of<MusicBloc>(context).add(
                            MusicPlayingSlider(sliderPosition: value.toInt()));
                      },
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_previous,
                      ),
                      color: Colors.white,
                      iconSize: 35,
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        if (state == MusicStopped()) {
                          BlocProvider.of<MusicBloc>(context)
                              .add(StartMusic(musicPath: music.path));
                        } else if (state is MusicPaused) {
                          BlocProvider.of<MusicBloc>(context).add(PlayMusic());
                        } else if (state is MusicPlaying) {
                          BlocProvider.of<MusicBloc>(context).add(PauseMusic());
                        }
                      },
                      color: Colors.white,
                      icon: state is MusicPlaying
                          ? const Icon(Icons.pause_rounded)
                          : const Icon(Icons.play_arrow_rounded),
                      iconSize: 35,
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {},
                      color: Colors.white,
                      icon: const Icon(Icons.skip_next),
                      iconSize: 35,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
