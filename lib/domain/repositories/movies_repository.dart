//* Importa la clase `Movie` desde el dominio de la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para el repositorio de películas.
abstract class MoviesRepository {
  //* Obtiene una lista de películas que están actualmente en cines.
  Future<List<Movie>> getNowPlaying({int page = 1});

  //* Obtiene una lista de películas próximas a estrenarse.
  Future<List<Movie>> getUpcoming({int page = 1});

  //* Obtiene una lista de películas populares.
  Future<List<Movie>> getPopular({int page = 1});

  //* Obtiene una lista de películas con las mejores calificaciones.
  Future<List<Movie>> getTopRated({int page = 1});

  //* Obtiene una película específica basada en su ID.
  Future<Movie> getMovieById(String id);

  //* Busca películas que coincidan con una consulta de búsqueda.
  Future<List<Movie>> searchMovies(String query);

  //* Obtiene una lista de películas similares basadas en el ID de una película.
  Future<List<Movie>> getSimilarMovies(int movieId);

  //* Obtiene una lista de videos de YouTube relacionados con una película por su ID.
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
