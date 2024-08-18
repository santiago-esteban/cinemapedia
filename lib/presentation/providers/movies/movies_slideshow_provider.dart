import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de estado para obtener una lista de películas para el slideshow.
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); // Observa el proveedor de películas en reproducción actual.
  if (nowPlayingMovies.isEmpty) return []; // Retorna una lista vacía si no hay películas en reproducción.
  return nowPlayingMovies.sublist(0, 10); // Retorna las primeras 6 películas de la lista para el slideshow.
});
