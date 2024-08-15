// Importa la clase `Actor` que representa a un actor en la aplicación.
import 'package:cinemapedia/domain/domain.dart';

//* Interfaz abstracta para el repositorio de actores.
abstract class ActorsRepository {
  //* Obtiene una lista de actores que están asociados con una película específica. Este método es asíncrono y recibe el ID de una película para buscar los actores correspondientes.
  Future<List<Actor>> getActorByMovie(String movieId);
}
