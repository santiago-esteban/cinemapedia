//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor para películas que se están reproduciendo actualmente
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Proveedor para películas próximas a estrenarse
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Proveedor para películas populares
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Proveedor para películas mejor valoradas
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Función para obtener una lista de películas dado un número de página
typedef MovieCallback = Future<List<Movie>> Function({int page});

//* Clase que maneja el estado de la lista de películas, incluyendo la lógica para cargar más páginas
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  //* Método para cargar la siguiente página de películas
  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage); //* Obtiene las películas de la siguiente página
    state = [...state, ...movies]; //* Actualiza el estado con las nuevas películas
    await Future.delayed(const Duration(milliseconds: 300)); //* Retrasa la carga para simular una transición suave
    isLoading = false;
  }
}
