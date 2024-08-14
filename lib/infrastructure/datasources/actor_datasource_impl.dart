// Importa las librerías y clases necesarias para la implementación del datasource de actores.
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

//* Implementación concreta del datasource para obtener datos de actores.
class ActorDatasourceImpl extends ActorsDatasource {
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

  //* Obtiene una lista de actores para una película específica usando su ID. Realiza una petición a la API para obtener los créditos de la película.
  //* Convierte la respuesta a un modelo interno y luego mapea los datos a entidades de 'Actor'.
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    // Realiza la petición HTTP para obtener los créditos de la película.
    final response = await dio.get('/movie/$movieId/credits');

    // Convierte la respuesta JSON en un objeto `CreditsResponse`.
    final castResponse = CreditsResponse.fromJson(response.data);

    // Mapea los datos de los actores desde el formato de la API a la entidad `Actor`.
    List<Actor> actors = castResponse.cast.map((cast) => ActorMapper.castDBToEntity(cast)).toList();

    // Retorna la lista de actores.
    return actors;
  }
}
