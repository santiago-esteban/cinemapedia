//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor para obtener una lista de películas destinadas a mostrarse en un slideshow
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //* Observa las películas que se están reproduciendo actualmente
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 10); //* Toma las primeras 10 películas de la lista para el slideshow
});
