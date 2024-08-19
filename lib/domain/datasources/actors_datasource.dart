//* Importa la clase `Actor` que representa a un actor en la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para obtener datos sobre actores.
abstract class ActorsDatasource {
  //* Obtiene una lista de actores basados en el ID de una película.
  Future<List<Actor>> getActorByMovie(String movieId);
}
