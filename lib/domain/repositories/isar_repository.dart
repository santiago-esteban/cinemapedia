//* Importa las clases y modelos del dominio de la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para el repositorio de datos en la base de datos Isar.
abstract class IsarRepository {
  //* Alterna el estado de favorito de una película.
  Future<void> toggleFavorite(Movie movie);

  //* Verifica si una película es favorita.
  Future<bool> isMovieFavorite(int movieId);

  //* Carga una lista de películas con un límite y desplazamiento opcionales.
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
