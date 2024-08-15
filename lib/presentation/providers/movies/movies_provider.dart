import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

//* Proveedor de estado para manejar la lista de películas que se están reproduciendo actualmente.
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying; // Obtiene la función getNowPlaying del repositorio de películas.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies); // Crea una instancia de MoviesNotifier con la función getNowPlaying.
});

//* Proveedor de estado para manejar la lista de películas próximas a estrenarse.
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming; // Obtiene la función getUpcoming del repositorio de películas.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies); // Crea una instancia de MoviesNotifier con la función getUpcoming.
});

//* Proveedor de estado para manejar la lista de películas populares.
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular; // Obtiene la función getPopular del repositorio de películas.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies); // Crea una instancia de MoviesNotifier con la función getPopular.
});

//* Proveedor de estado para manejar la lista de películas mejor valoradas.
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated; // Obtiene la función getTopRated del repositorio de películas.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies); // Crea una instancia de MoviesNotifier con la función getTopRated.
});

typedef MovieCallback = Future<List<Movie>> Function({int page}); // Callback para obtener una lista de películas dado un número de página.

//* Clase que maneja el estado de la lista de películas, incluyendo la carga de más páginas.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0; // Página actual para la carga de más películas.
  bool isLoading = false; // Indica si se está cargando más contenido.
  MovieCallback fetchMoreMovies; // Función de callback para obtener más películas.

  MoviesNotifier({required this.fetchMoreMovies}) : super([]); // Constructor que inicializa el estado con una lista vacía.

  //* Método para cargar la siguiente página de películas.
  Future<void> loadNextPage() async {
    if (isLoading) return; // Evita la carga si ya se está cargando.
    isLoading = true; // Marca como cargando.
    currentPage++; // Incrementa el número de página.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage); // Obtiene las películas de la página actual.
    state = [...state, ...movies]; // Actualiza el estado con las nuevas películas.
    await Future.delayed(const Duration(milliseconds: 300)); // Retrasa la carga.
    isLoading = false; // Marca como no cargando.
  }
}
