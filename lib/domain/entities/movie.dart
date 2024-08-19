//* Importa la librería para la integración con Isar, una base de datos.
import 'package:isar/isar.dart';

//* Parte del archivo generado automáticamente por Isar.
part 'movie.g.dart';

//* Clase que representa una película. Anota que la clase `Movie` es una colección de Isar.
@collection
class Movie {
  Id? isarId;
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  //* Constructor para crear una instancia de `Movie`.
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
