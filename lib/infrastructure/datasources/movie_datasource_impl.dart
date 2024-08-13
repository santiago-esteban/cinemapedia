import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

//* Implementación del datasource de películas, que maneja las peticiones HTTP hacia la API de The Movie Database (TMDB).
class MovieDatasourceImpl extends MoviesDatasource {
  //* Instancia de Dio configurada con la URL base de la API de TMDB y los parámetros de consulta comunes, como la clave API y el idioma.
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
        'language': 'es',
      },
    ),
  );

  //* Método privado que convierte una respuesta JSON en una lista de entidades de tipo Movie.
  // Filtra las películas que no tienen un poster válido y utiliza el MovieMapper para mapear las películas desde el modelo de datos de la API hacia la entidad Movie.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

  //* Petición HTTP que recupera una lista de las películas actuales.
  // Llama a la API de TMDB para obtener las películas que están en cartelera. Parámetro opcional `page` para la paginación.
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Petición HTTP que recupera una lista de las películas que saldrán próximamente.
  // Llama a la API de TMDB para obtener las películas que estarán disponibles próximamente. Parámetro opcional `page` para la paginación.
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Petición HTTP que recupera una lista de las películas más populares.
  // Llama a la API de TMDB para obtener las películas más populares en la plataforma. Parámetro opcional `page` para la paginación.
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Petición HTTP que recupera una lista de las películas mejor valoradas.
  // Llama a la API de TMDB para obtener las películas mejor valoradas por los usuarios. Parámetro opcional `page` para la paginación.
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Petición HTTP que recupera los detalles de una película individual a través de su ID.
  // Llama a la API de TMDB para obtener los detalles de una película específica. Si no se encuentra la película, lanza una excepción.
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  //* Petición HTTP que busca películas a través de una consulta de texto.
  // Llama a la API de TMDB para buscar películas basadas en una consulta proporcionada por el usuario. Si la consulta está vacía, devuelve una lista vacía.
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }
}
