import 'package:app_stre_pro_flutter/Pelicula.dart';
import 'package:app_stre_pro_flutter/screen/ReproductorScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_stre_pro_flutter/Peliculas.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los Widgets estén inicializados
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(const ListaCon());
}

class ListaCon extends StatelessWidget {
  const ListaCon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        title: const Text('Lista'),
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
              builder: (context) => PantallaTituloPelicula(
                titulo: pelicula.titulo,
                descripcion: pelicula.descripcion,
                categoria: pelicula.categoria,
                duracion: pelicula.duracion,
                poster: pelicula.poster,
                url: pelicula.url,
              ),
            ),
          );
        },
      ),
    );
  }
}
