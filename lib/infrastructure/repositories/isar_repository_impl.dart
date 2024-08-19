//* Importaciones necesarias para el repositorio de Isar.
import 'package:cinemapedia/domain/domain.dart';

//* Implementación del repositorio de Isar.
class IsarRepositoryImpl extends IsarRepository {
  final IsarDatasource datasource;

  //* Constructor que inicializa el datasource.
  IsarRepositoryImpl({required this.datasource});

  //* Método para verificar si una película es favorita.
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  //* Método para cargar una lista de películas con un límite y un desplazamiento.
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  //* Método para alternar el estado de favorito de una película.
  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
