//* Importa las clases necesarias para el mapeo de datos de actores.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';

//* Clase encargada de mapear datos de actores desde el modelo de la API a la entidad de la aplicación.
class ActorMapper {
  //* Convierte un objeto `Cast` (del modelo de la API) a una entidad `Actor`.
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath:
            cast.profilePath != null ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxKOYPyF-MeWe6p_HA_AWU0J0nVHhwrQrZFA&usqp=CAU',
        character: cast.character,
      );
}
