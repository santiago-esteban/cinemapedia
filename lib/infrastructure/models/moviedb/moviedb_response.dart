import 'movie_moviedb.dart';

//* Clase que representa la respuesta de una consulta a la API de MovieDB.
class MovieDbResponse {
  //* Constructor de la clase.
  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates; // Rango de fechas de las películas en la respuesta, puede ser nulo.
  final int page; // Número de página de la respuesta actual.
  final List<MovieMovieDB> results; // Lista de películas en la respuesta.
  final int totalPages; // Número total de páginas disponibles.
  final int totalResults; // Número total de resultados disponibles.

  //* Método para crear una instancia de MovieDbResponse a partir de un JSON.
  factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  //* Método para convertir una instancia de MovieDbResponse a JSON.
  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

//* Clase que representa un rango de fechas.
class Dates {
  //* Constructor de la clase.
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime maximum; // Fecha máxima del rango.
  final DateTime minimum; // Fecha mínima del rango.

  //* Método para crear una instancia de Dates a partir de un JSON.
  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]), // Convierte la fecha máxima a DateTime.
        minimum: DateTime.parse(json["minimum"]), // Convierte la fecha mínima a DateTime.
      );

  //* Método para convertir una instancia de Dates a JSON.
  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}", // Formatea la fecha máxima como 'yyyy-MM-dd'.
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}", // Formatea la fecha mínima como 'yyyy-MM-dd'.
      };
}
