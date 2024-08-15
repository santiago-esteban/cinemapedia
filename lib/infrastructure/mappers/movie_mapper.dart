// Importa las clases necesarias para mapear datos de películas desde el modelo de la API a las entidades de la aplicación.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/infrastructure.dart';

//* Clase responsable de convertir datos de películas desde el formato de la API a entidades utilizadas en la aplicación.
class MovieMapper {
  //* Mapea un objeto `MovieMovieDB` (modelo de la API) a una entidad `Movie`.
  static Movie movieDBToEntity(MovieResponse moviedb) => Movie(
        adult: moviedb.adult, // Indica si la película es para adultos.
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' // URL del fondo de la película.
            : 'https://www.movienewz.com/img/films/poster-holder.jpg', // Imagen por defecto.
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), // Conversión de los IDs de género a String.
        id: moviedb.id, // Identificador único de la película.
        originalLanguage: moviedb.originalLanguage, // Idioma original de la película.
        originalTitle: moviedb.originalTitle, // Título original de la película.
        overview: moviedb.overview, // Resumen de la película.
        popularity: moviedb.popularity, // Popularidad de la película.
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' // URL del póster de la película.
            : 'https://www.movienewz.com/img/films/poster-holder.jpg', // Imagen por defecto.
        releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime(0000, 00, 00), // Fecha de lanzamiento.
        title: moviedb.title, // Título de la película.
        video: moviedb.video, // Indica si hay un video/tráiler asociado.
        voteAverage: moviedb.voteAverage, // Promedio de valoración.
        voteCount: moviedb.voteCount, // Cantidad de valoraciones.
      );

  //* Mapea un objeto `MovieDetails` (modelo de la API) a una entidad `Movie`.
  static Movie movieDetailsToEntity(DetailsResponse moviedb) => Movie(
        adult: moviedb.adult, // Indica si la película es para adultos.
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' // URL del fondo de la película.
            : 'https://www.movienewz.com/img/films/poster-holder.jpg', // Imagen por defecto.
        genreIds: moviedb.genres.map((e) => e.name).toList(), // Mapea los géneros a sus nombres.
        id: moviedb.id, // Identificador único de la película.
        originalLanguage: moviedb.originalLanguage, // Idioma original de la película.
        originalTitle: moviedb.originalTitle, // Título original de la película.
        overview: moviedb.overview, // Resumen de la película.
        popularity: moviedb.popularity, // Nivel de popularidad de la película.
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' // URL del póster de la película.
            : 'https://www.movienewz.com/img/films/poster-holder.jpg', // Imagen por defecto.
        releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime(0000, 00, 00), // Fecha de lanzamiento.
        title: moviedb.title, // Título de la película.
        video: moviedb.video, // Indica si hay un video asociado.
        voteAverage: moviedb.voteAverage, // Promedio de valoración.
        voteCount: moviedb.voteCount, // Cantidad de valoraciones.
      );
}
