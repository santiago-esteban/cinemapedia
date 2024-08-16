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

  Future<void> loadNextPage() async {
    final movies = await isarRepository.loadMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
  }
}