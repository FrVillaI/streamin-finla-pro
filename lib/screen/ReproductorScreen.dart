import 'package:flutter/material.dart';

class PantallaTituloPelicula extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String categoria;
  final String duracion;
  final String poster;
  final String url;

  const PantallaTituloPelicula({
    Key? key,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.duracion,
    required this.poster,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(poster),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 0.5), // Color semitransparente (ajusta el último valor para la opacidad)
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 270.0),
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Categoría: $categoria',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duración: $duracion',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    descripcion,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Acción para reproducir la película
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Reproducir'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Acción para agregar a favoritos
                        },
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Favoritos'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
