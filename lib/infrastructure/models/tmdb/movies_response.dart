//* Importa la clase MovieResponse, que representa los datos de una película obtenida de MovieDB.
import 'movie_response.dart';

//* Clase que representa la respuesta de una consulta a la API de MovieDB.
class MoviesResponse {
  MoviesResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final int page;
  final List<MovieResponse> results;
  final int totalPages;
  final int totalResults;

  //* Método para crear una instancia de MoviesResponse a partir de un JSON.
  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieResponse>.from(json["results"].map((x) => MovieResponse.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  //* Método para convertir una instancia de MoviesResponse a JSON.
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
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime maximum;
  final DateTime minimum;

  //* Método para crear una instancia de Dates a partir de un JSON.
  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  //* Método para convertir una instancia de Dates a JSON.
  Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
