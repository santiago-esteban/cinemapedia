//* Importaciones de paquetes necesarios.
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Enlace de póster de película
class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    //* Inicializa una instancia de Random para generar números aleatorios
    final random = Random();

    //* Widget para animar la aparición del póster con un desplazamiento y retraso aleatorio
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450)),
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            height: 180,
            fit: BoxFit.cover,
            //* Imagen de carga
            placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
            //* Imagen del póster
            image: NetworkImage(movie.posterPath),
          ),
        ),
      ),
    );
  }
}
