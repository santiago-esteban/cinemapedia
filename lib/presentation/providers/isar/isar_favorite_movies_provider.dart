//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/providers/isar/isar_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor que gestiona el estado de las películas favoritas utilizando Isar como repositorio
final isarFavoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final isarRepository = ref.watch(isarRepositoryProvider);
  return FavoriteMoviesNotifier(isarRepository: isarRepository);
});

//* Notifier que maneja la lógica de las películas favoritas
class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final IsarRepository isarRepository;

  FavoriteMoviesNotifier({required this.isarRepository}) : super({}); //* Inicializa el estado con un mapa vacío

  //* Carga la siguiente página de películas favoritas desde el repositorio
  Future<List<Movie>> loadNextPage() async {
    final movies = await isarRepository.loadMovies(offset: page * 10, limit: 20);
    page++;
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = {...state, ...tempMoviesMap}; //* Actualiza el estado con las nuevas películas
    return movies;
  }

  //* Alterna el estado de una película entre favorita y no favorita
  Future<void> toggleFavorite(Movie movie) async {
    await isarRepository.toggleFavorite(movie); //* Actualiza el estado en el repositorio
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id); //* Elimina la película de favoritos si ya está en el estado
      state = {...state};
    } else {
      state = {...state, movie.id: movie}; //* Añade la película a favoritos si no está en el estado
    }
  }
}
