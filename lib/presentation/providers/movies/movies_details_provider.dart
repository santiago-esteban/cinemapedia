//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de estado que gestiona la información de detalles de películas
final movieDetailsProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(movieRepository);
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId); //* Definición del callback para obtener una película por ID

//* Notifier que maneja el estado de las películas en un mapa
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  MovieMapNotifier(this.getMovie) : super({});

  //* Carga la información de una película específica si no está ya en el estado
  Future<void> loadMovie({required String movieId}) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie}; //* Actualiza el estado con la nueva película
  }
}
