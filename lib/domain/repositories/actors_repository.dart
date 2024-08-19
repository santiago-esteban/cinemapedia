//* Importa la clase `Actor` desde el dominio de la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para el repositorio de actores.
abstract class ActorsRepository {
  //* Obtiene una lista de actores asociados con una película específica.
  Future<List<Actor>> getActorByMovie(String movieId);
}
