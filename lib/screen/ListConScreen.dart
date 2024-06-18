import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_stre_pro_flutter/Pelicula.dart';
import 'package:app_stre_pro_flutter/screen/ReproductorScreen.dart';
import 'package:app_stre_pro_flutter/Peliculas.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ListaCon());
}

class ListaCon extends StatelessWidget {
  const ListaCon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Pelicula>> _futurePeliculas;

  @override
  void initState() {
    super.initState();
    _futurePeliculas = _fetchPeliculas();
  }

  Future<List<Pelicula>> _fetchPeliculas() async {
    try {
      Peliculas peliculasProvider = Peliculas();
      List<Pelicula> peliculas = await peliculasProvider.getPeliculas();
      print('Peliculas obtenidas: ${peliculas.length}');
      return peliculas;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas Disponibles'),
      ),
      body: FutureBuilder<List<Pelicula>>(
        future: _futurePeliculas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          } else {
            return _buildBody(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildBody(List<Pelicula> peliculas) {
    return ListView.builder(
      itemCount: peliculas.length,
      itemBuilder: (context, index) {
        return _buildMovieCard(context, peliculas[index]);
      },
    );
  }

  Widget _buildMovieCard(BuildContext context, Pelicula pelicula) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(pelicula.titulo),
        subtitle: Text(pelicula.descripcion),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Play(
                url: pelicula.url,
                titulo: pelicula.titulo,
              ),
            ),
          );
        },
      ),
    );
  }
}

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
          HomePlayer(url: widget.url),
        ],
      ),
    );
  }
}

class HomePlayer extends StatefulWidget {
  final String url;

  const HomePlayer({super.key, required this.url});

  @override
  State<HomePlayer> createState() => _HomePlayerState();
}

class _HomePlayerState extends State<HomePlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
    );
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
