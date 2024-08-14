// Importa la clase `Movie` que representa una película en la aplicación.
import 'package:cinemapedia/domain/entities/movie.dart';

//* Interfaz abstracta para obtener datos sobre películas.
abstract class MoviesDatasource {
  // Obtiene una lista de películas que están actualmente en cines. El parámetro `page` permite la paginación de los resultados, con un valor por defecto de 1.
  Future<List<Movie>> getNowPlaying({int page = 1});

  // Obtiene una lista de películas próximas a estrenarse. El parámetro `page` permite la paginación de los resultados, con un valor por defecto de 1.
  Future<List<Movie>> getUpcoming({int page = 1});

  // Obtiene una lista de películas populares. El parámetro `page` permite la paginación de los resultados, con un valor por defecto de 1.
  Future<List<Movie>> getPopular({int page = 1});

  // Obtiene una lista de películas con las mejores calificaciones. El parámetro `page` permite la paginación de los resultados, con un valor por defecto de 1.
  Future<List<Movie>> getTopRated({int page = 1});

  // Obtiene una película específica basada en su ID.
  Future<Movie> getMovieById(String id);

  // Busca películas que coincidan con una consulta de búsqueda.
  Future<List<Movie>> searchMovies(String query);
}
