import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
            : 'https://img.freepik.com/free-vector/young-woman-protesting-with-round-banner-meeting-stop-attention-flat-vector-illustration-demonstration-active-position-concept-mobile-app-template_74855-12669.jpg?size=626&ext=jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '') ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' : 'no-poster',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
            : 'https://img.freepik.com/free-vector/young-woman-protesting-with-round-banner-meeting-stop-attention-flat-vector-illustration-demonstration-active-position-concept-mobile-app-template_74855-12669.jpg?size=626&ext=jpg',
        genreIds: moviedb.genres.map((e) => e.name).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
            : 'https://img.freepik.com/free-vector/young-woman-protesting-with-round-banner-meeting-stop-attention-flat-vector-illustration-demonstration-active-position-concept-mobile-app-template_74855-12669.jpg?size=626&ext=jpg',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );
}
