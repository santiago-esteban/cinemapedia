//* Importa las librerías necesarias para la implementación del datasource de películas.
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

//* Implementación concreta del datasource para obtener datos de películas.
class MovieDatasourceImpl extends MoviesDatasource {
  //* Instancia de Dio para manejar las peticiones HTTP.
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
        'language': 'es',
      },
    ),
  );

  //* Convierte la respuesta JSON de la API en una lista de objetos `Movie`.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieResponse = MoviesResponse.fromJson(json);
    final List<Movie> movies = movieResponse.results.where((moviedb) => moviedb.posterPath != 'no-poster').map((moviedb) => MovieMapper.movieToEntity(moviedb)).toList();
    return movies;
  }

  //* Obtiene una lista de películas que están actualmente en cines.
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Obtiene una lista de películas próximas a estrenarse.
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Obtiene una lista de películas populares.
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Obtiene una lista de películas con las mejores calificaciones.
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //* Obtiene detalles de una película específica usando su ID.
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');
    final movieDetails = DetailsResponse.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  //* Busca películas que coincidan con una consulta de búsqueda.
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }

  //* Obtiene una lista de películas similares basadas en el ID de una película.
  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar');
    return _jsonToMovies(response.data);
  }

  //* Obtiene una lista de videos de YouTube relacionados con una película por su ID.
  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final movieVideosReponse = VideosResponse.fromJson(response.data);
    final videos = <Video>[];
    for (final moviedbVideo in movieVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }
    return videos;
  }
}
