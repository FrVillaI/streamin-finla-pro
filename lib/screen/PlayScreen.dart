import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class Play extends StatefulWidget {
  final String titulo;
  final String url;

  const Play({Key? key, required this.url, required this.titulo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: Stack(
        children: [
          Home(url: widget.url),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  final String url;

  const Home({super.key, required this.url});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
    );
    // Ocultar la barra de navegación en pantalla completa
    flickManager.flickControlManager!.addListener(_handleFullScreen);
  }

  void _handleFullScreen() {
    if (flickManager.flickControlManager!.isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    flickManager.flickControlManager!.removeListener(_handleFullScreen);
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(
            flickManager: flickManager,
          ),
        ),
      ),
    );
  }
}
