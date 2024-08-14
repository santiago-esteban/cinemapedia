// Importa la clase `Actor` que representa a un actor en la aplicación.
import 'package:cinemapedia/domain/entities/actor.dart';

//* Interfaz abstracta para obtener datos sobre actores.
abstract class ActorsDatasource {
  // Método para obtener una lista de actores basados en el ID de una película. Este método es asíncrono y devuelve una lista de actores.
  Future<List<Actor>> getActorByMovie(String movieId);
}
