import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/providers/isar/isar_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isarFavoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final isarRepository = ref.watch(isarRepositoryProvider);
  return FavoriteMoviesNotifier(isarRepository: isarRepository);
});

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final IsarRepository isarRepository;

  FavoriteMoviesNotifier({required this.isarRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await isarRepository.loadMovies(offset: page * 10, limit: 20);
    page++;
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await isarRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
