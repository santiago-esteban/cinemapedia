//* Importa las clases necesarias para mapear datos de videos.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';

//* Clase encargada de mapear datos de videos desde el modelo de la API a la entidad de la aplicación.
class VideoMapper {
  //* Convierte un objeto `Result` (modelo de la API) a una entidad `Video`.
  static moviedbVideoToEntity(Result moviedbVideo) => Video(
        id: moviedbVideo.id,
        name: moviedbVideo.name,
        youtubeKey: moviedbVideo.key,
        publishedAt: moviedbVideo.publishedAt,
      );
}
