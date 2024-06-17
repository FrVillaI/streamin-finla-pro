import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(Play());
}

class Play extends StatelessWidget {
  const Play({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse('https://firebasestorage.googleapis.com/v0/b/app-streamin-flutter.appspot.com/o/pelis%2FAlandin.mp4?alt=media&token=5eca31fa-ec18-4840-b19b-f4cdf7ee707e')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play'),
      ),
      body: Center(
          child: AspectRatio(
        aspectRatio: 16 / 10,
        child: FlickVideoPlayer(
          flickManager: flickManager,
        ),
      )),
    );
  }
}
