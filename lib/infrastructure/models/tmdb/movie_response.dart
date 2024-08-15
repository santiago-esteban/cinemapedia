//* Clase que representa los datos de una película obtenida de MovieDB.
class MovieResponse {
  //* Constructor de la clase.
  MovieResponse({
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

  final bool adult; // Indica si la película es solo para adultos.
  final String backdropPath; // Ruta de la imagen de fondo de la película.
  final List<int> genreIds; // Lista de IDs de géneros asociados a la película.
  final int id; // Identificador único de la película.
  final String originalLanguage; // Idioma original de la película.
  final String originalTitle; // Título original de la película.
  final String overview; // Resumen de la trama de la película.
  final double popularity; // Popularidad de la película.
  final String posterPath; // Ruta del póster de la película.
  final DateTime? releaseDate; // Fecha de estreno de la película. Puede ser nulo.
  final String title; // Título de la película.
  final bool video; // Indica si la película es un video.
  final double voteAverage; // Promedio de valoraciones que ha recibido la película.
  final int voteCount; // Número total de valoraciones que ha recibido la película.

  //* Método para crear una instancia de MovieResponse a partir de un JSON.
  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        posterPath: json["poster_path"] ?? '',
        releaseDate: json["release_date"] != null && json["release_date"].toString().isNotEmpty ? DateTime.parse(json["release_date"]) : null,
        title: json["title"] ?? 'El título no está disponible',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );

  //* Método para convertir una instancia de MovieResponse a JSON.
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate != null ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}" : null,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
