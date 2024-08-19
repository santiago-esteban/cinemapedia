//* Importa las clases necesarias para mapear datos de películas desde el modelo de la API a las entidades de la aplicación.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';

//* Clase responsable de convertir datos de películas desde el formato de la API a entidades utilizadas en la aplicación.
class MovieMapper {
  //* Mapea un objeto `MovieResponse` (modelo de la API) a una entidad `Movie`.
  static Movie movieToEntity(MovieResponse moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '') ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '') ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime(0000, 00, 00),
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  //* Mapea un objeto `DetailsResponse` (modelo de la API) a una entidad `Movie`.
  static Movie movieDetailsToEntity(DetailsResponse moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '') ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        genreIds: moviedb.genres.map((e) => e.name).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '') ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime(0000, 00, 00),
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}
