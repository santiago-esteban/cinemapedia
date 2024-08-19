//* Importa las librerías y clases necesarias para la implementación del datasource de actores.
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

//* Implementación concreta del datasource para obtener datos de actores.
class ActorDatasourceImpl extends ActorsDatasource {
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

  //* Obtiene una lista de actores para una película específica usando su ID.
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
    return actors;
  }
}
