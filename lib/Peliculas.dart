import 'package:app_stre_pro_flutter/Pelicula.dart';
import 'package:firebase_database/firebase_database.dart';

class Peliculas {
  Future<List<Pelicula>> getPeliculas() async {
    List<Pelicula> peliculasDis = [];
    try {
      final event = await FirebaseDatabase.instance.ref('peliculas').once();

      var data = event.snapshot.value;

      if (data != null && data is List) {
        for (var item in data) {
          if (item != null && item is Map<dynamic, dynamic>) {
            if (item['titulo'] != null &&
                item['descripcion'] != null &&
                item['id'] != null &&
                item['categoria'] != null &&
                item['duracion'] != null &&
                item['poster'] != null &&
                item['url'] != null) {
              Pelicula nuevaPelicula = Pelicula(
                key: item['id'],
                titulo: item['titulo'],
                descripcion: item['descripcion'],
                categoria: item['categoria'],
                duracion: item['duracion'],
                poster: item['poster'],
                url: item['url'],
              );
              peliculasDis.add(nuevaPelicula);
            }
          }
        }
      } else {
        print('Los datos obtenidos no son una lista válida');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return peliculasDis;
  }
}
