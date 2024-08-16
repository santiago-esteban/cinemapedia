import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isarFavoriteProvider = StateNotifierProvider.family<FavoriteNotifier, bool, int>((ref, movieId) {
  final isarRepository = ref.watch(isarRepositoryProvider);
  return FavoriteNotifier(isarRepository, movieId);
});

class FavoriteNotifier extends StateNotifier<bool> {
  final IsarRepository _isarRepository;
  final int _movieId;

  FavoriteNotifier(this._isarRepository, this._movieId) : super(false) {
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await _isarRepository.isMovieFavorite(_movieId);
    state = isFavorite;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await _isarRepository.toggleFavorite(movie);
    state = !state;
  }
}
