//* Clase que representa una película en la aplicación.
import 'package:isar/isar.dart';

part 'movie.g.dart';

@collection
class Movie {
  Id? isarId;
  final bool adult; // Indica si la película es para adultos.
  final String backdropPath; // Ruta de la imagen de fondo de la película.
  final List<String> genreIds; // Lista de identificadores de géneros asociados a la película.
  final int id; // Identificador único de la película.
  final String originalLanguage; // Idioma original en el que se hizo la película.
  final String originalTitle; // Título original de la película.
  final String overview; // Resumen o descripción de la película.
  final double popularity; // Popularidad de la película.
  final String posterPath; // Ruta del póster de la película.
  final DateTime releaseDate; // Fecha de estreno de la película.
  final String title; // Título de la película.
  final bool video; // Indica si hay un video asociado (por ejemplo, un tráiler).
  final double voteAverage; // Promedio de valoración recibida por la película.
  final int voteCount; // Número total de valoraciones recibidas por la película.

  //* Constructor para crear una instancia de `Movie`. Todos los parámetros son obligatorios y deben ser proporcionados al crear una instancia de `Movie`.
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
