// Importaciones necesarias para el repositorio de películas.
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

//* Implementación del repositorio de películas.
class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource; // Instancia del datasource que proporcionará los datos de las películas.

  MovieRepositoryImpl(this.datasource); // Constructor que inicializa el datasource.

  //* Método para obtener la lista de películas que están en cartelera.
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  //* Método para obtener la lista de próximas películas.
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  //* Método para obtener la lista de películas populares.
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  //* Método para obtener la lista de películas mejor calificadas.
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  //* Método para obtener una película específica por su ID.
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  //* Método para buscar películas basadas en una consulta de texto.
  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}
