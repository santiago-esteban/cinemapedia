//* Importa las clases y modelos del dominio de la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para manejar operaciones relacionadas con la base de datos de Isar.
abstract class IsarDatasource {
  //* Alterna el estado de favorito de una película.
  Future<void> toggleFavorite(Movie movie);

  //* Verifica si una película es favorita basándose en su ID.
  Future<bool> isMovieFavorite(int movieId);

  //* Carga una lista de películas con un límite y un desplazamiento opcional.
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
