// Importa las librerías necesarias para la implementación del datasource de películas.
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:dio/dio.dart';

//* Implementación concreta del datasource para obtener datos de películas.
class MovieDatasourceImpl extends MoviesDatasource {
  //* Instancia de Dio para manejar las peticiones HTTP.
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3', // URL base de la API de The Movie Database.
      queryParameters: {
        'api_key': Environment.tmdbKey, // Clave de API para autenticar las peticiones.
        'language': 'es', // Idioma de las respuestas de la API.
      },
    ),
  );

  //* Convierte la respuesta JSON de la API en una lista de objetos `Movie`. Filtra las películas que no tienen un póster y las convierte usando el mapeador `MovieMapper`.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MoviesResponse.fromJson(json); // Convierte JSON en un objeto `MovieDbResponse`.
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster') // Filtra películas sin póster.
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb)) // Mapea a objetos `Movie`.
        .toList();
    return movies;
  }

  //* Obtiene una lista de películas que están actualmente en cines. Realiza una petición HTTP y convierte la respuesta en una lista de objetos `Movie`.
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data); // Convierte la respuesta JSON a objetos `Movie`.
  }

  //* Obtiene una lista de películas próximas a estrenarse. Realiza una petición HTTP y convierte la respuesta en una lista de objetos `Movie`.
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data); // Convierte la respuesta JSON a objetos `Movie`.
  }

  //* Obtiene una lista de películas populares. Realiza una petición HTTP y convierte la respuesta en una lista de objetos `Movie`.
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data); // Convierte la respuesta JSON a objetos `Movie`.
  }

  //* Obtiene una lista de películas con las mejores calificaciones. Realiza una petición HTTP y convierte la respuesta en una lista de objetos `Movie`.
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data); // Convierte la respuesta JSON a objetos `Movie`.
  }

  //* Obtiene detalles de una película específica usando su ID. Realiza una petición HTTP para obtener los detalles de la película y convierte la respuesta en un objeto `Movie`.
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found'); // Manejo de errores.
    final movieDetails = DetailsResponse.fromJson(response.data); // Convierte JSON en `MovieDetails`.
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails); // Mapea a objeto `Movie`.
    return movie;
  }

  //* Busca películas que coincidan con una consulta de búsqueda. Realiza una petición HTTP con la consulta proporcionada y convierte la respuesta en una lista de objetos `Movie`.
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return []; // Devuelve una lista vacía si la consulta está vacía.
    final response = await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data); // Convierte la respuesta JSON a objetos `Movie`.
  }
}
