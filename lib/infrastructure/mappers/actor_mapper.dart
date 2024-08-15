// Importa las clases necesarias para el mapeo de datos de actores.
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/credits_response.dart';

//* Clase encargada de mapear datos de actores desde el modelo de la API a la entidad de la aplicación.
class ActorMapper {
  //* Convierte un objeto `Cast` (del modelo de la API) a una entidad `Actor`.
  static Actor castDBToEntity(Cast cast) => Actor(
        id: cast.id, // Identificador del actor.
        name: cast.name, // Nombre del actor.
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}' // URL de la imagen del perfil del actor.
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxKOYPyF-MeWe6p_HA_AWU0J0nVHhwrQrZFA&usqp=CAU', // Imagen por defecto si no hay foto de perfil.
        character: cast.character, // Nombre del personaje interpretado por el actor (opcional).
      );
}
