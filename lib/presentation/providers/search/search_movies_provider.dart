import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de estado para manejar la consulta de búsqueda de películas.
final searchQueryProvider = StateProvider<String>((ref) => ''); // Inicializa el estado de la consulta de búsqueda como una cadena vacía.

//* Proveedor de estado para manejar la lista de películas buscadas.
final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider); // Obtiene el repositorio de películas del proveedor.
  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovies, // Pasa la función de búsqueda de películas al notifier.
    ref: ref, // Pasa la referencia al proveedor para acceder a otros proveedores.
  );
});

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query); // Callback para la búsqueda de películas por consulta.

//* Clase que maneja el estado de las películas buscadas y la lógica de búsqueda.
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallBack searchMovies; // Callback para buscar películas basado en la consulta.
  final Ref ref; // Referencia al objeto de estado para acceder a otros proveedores.

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]); // Inicializa el estado con una lista vacía.

  //* Método para buscar películas basado en la consulta proporcionada.
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query); // Ejecuta la búsqueda de películas.
    ref.read(searchQueryProvider.notifier).update((state) => query); // Actualiza la consulta de búsqueda en el proveedor.
    state = movies; // Actualiza el estado con las películas encontradas.
    return movies; // Retorna la lista de películas encontradas.
  }
}
