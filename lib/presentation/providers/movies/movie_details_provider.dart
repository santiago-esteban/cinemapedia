import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

//* Proveedor de estado para manejar la información de películas.
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieDetails = ref.watch(movieRepositoryProvider).getMovieById; // Obtiene la función getMovieById del repositorio de películas.
  return MovieMapNotifier(movieDetails); // Crea una instancia de MovieMapNotifier con la función getMovieById.
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId); // Callback para obtener una película dado un ID.

//* Clase que maneja el estado de las películas.
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie; // Función de callback para obtener una película basada en el ID.

  MovieMapNotifier(this.getMovie) : super({}); // Constructor que inicializa el estado con un mapa vacío.

  //* Método para cargar la información de una película específica.
  Future<void> loadMovie({required String movieId}) async {
    if (state[movieId] != null) return; // Verifica si la película ya está en el estado.
    final movie = await getMovie(movieId); // Obtiene la película llamando a la función getMovie.
    state = {...state, movieId: movie}; // Actualiza el estado con la película obtenida.
  }
}