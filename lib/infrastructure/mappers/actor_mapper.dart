import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castDBToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://img.freepik.com/free-vector/young-woman-protesting-with-round-banner-meeting-stop-attention-flat-vector-illustration-demonstration-active-position-concept-mobile-app-template_74855-12669.jpg?size=626&ext=jpg',
        character: cast.character,
      );
}
