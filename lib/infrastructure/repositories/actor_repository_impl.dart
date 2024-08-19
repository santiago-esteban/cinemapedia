//* Importaciones necesarias para el repositorio de actores.
import 'package:cinemapedia/domain/domain.dart';

//* Implementación del repositorio de actores.
class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  //* Constructor que inicializa el datasource.
  ActorRepositoryImpl(this.datasource);

  //* Método para obtener la lista de actores de una película específica.
  @override
  Future<List<Actor>> getActorByMovie(String movieId) {
    return datasource.getActorByMovie(movieId);
  }
}
