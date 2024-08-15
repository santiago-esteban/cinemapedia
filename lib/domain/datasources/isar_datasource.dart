import 'package:cinemapedia/domain/domain.dart';

abstract class IsarDatasource {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
