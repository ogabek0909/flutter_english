import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
  }

  void play () async {
                if (!isPlaying) {
                  await player.play(
                    AssetSource(
                        'music/KONSTA-O-zbekistonlik-Official-Soundtrack-4K.m4a'),
                  );
                } else {
                  await player.pause();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });

              }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My English Musics"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: play,
            leading: const Icon(Icons.music_note),
            title: const Text('O\'zbekistonlik'),
            trailing: IconButton(
              onPressed: play,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ),
        ],
      ),
    );
  }
}
