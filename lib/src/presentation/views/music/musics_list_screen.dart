import 'package:flutter/material.dart';


class MusicListScreen extends StatelessWidget {
  const MusicListScreen({super.key});
  static const routeName = 'music-list-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My English Musics"),
      ),
      backgroundColor: Colors.amber,
    );
  }
}