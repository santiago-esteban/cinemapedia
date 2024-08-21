//* Importaciones necesarias para el funcionamiento del widget y la lógica de negocio
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor que obtiene las películas similares dado un ID de película
final moviesSimilarProvider = FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieId);
});

//* Widget que muestra una lista de películas similares
class MoviesSimilar extends ConsumerWidget {
  final int movieId;

  const MoviesSimilar({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* Observa el proveedor de películas similares para cargar los datos
    final similarMoviesFuture = ref.watch(moviesSimilarProvider(movieId));

    return similarMoviesFuture.when(
      data: (movies) => _Recomendations(movies: movies),
      error: (_, __) => const Center(child: Text('No se pudo cargar películas similares')),
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

//* Widget que muestra las recomendaciones de películas en una lista
class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    //* Muestra las recomendaciones de películas en una lista vertical
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MoviesListview(title: 'Recomendaciones', movies: movies),
    );
  }
}
