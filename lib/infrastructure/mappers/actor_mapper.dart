import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castDBToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxKOYPyF-MeWe6p_HA_AWU0J0nVHhwrQrZFA&usqp=CAU',
        character: cast.character,
      );
}
