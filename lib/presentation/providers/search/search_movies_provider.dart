//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor para manejar la consulta de búsqueda de películas
final searchQueryProvider = StateProvider<String>((ref) => '');

//* Proveedor para manejar la lista de películas buscadas
final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovies,
    ref: ref,
  );
});

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query); //* Callback para la búsqueda de películas

//* Notifier que maneja el estado de las películas buscadas y la lógica de búsqueda
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallBack searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  //* Método para realizar la búsqueda de películas según la consulta proporcionada
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query); //* Ejecuta la búsqueda de películas
    ref.read(searchQueryProvider.notifier).update((state) => query); //* Actualiza la consulta de búsqueda en el proveedor
    state = movies; //* Actualiza el estado con las películas encontradas
    return movies;
  }
}
