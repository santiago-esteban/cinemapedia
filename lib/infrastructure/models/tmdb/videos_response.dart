//* Clase que representa la respuesta de la API para los videos de una película.
class VideosResponse {
  VideosResponse({
    required this.id,
    required this.results,
  });

  final int id;
  final List<Result> results;

  //* Método para crear una instancia de VideosResponse a partir de un JSON.
  factory VideosResponse.fromJson(Map<String, dynamic> json) => VideosResponse(
        id: json["id"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  //* Método para convertir una instancia de VideosResponse a JSON.
  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

//* Clase que representa un video asociado a una película.
class Result {
  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  //* Método para crear una instancia de Result a partir de un JSON.
  factory Result.fromJson(Map<String, dynamic> json) => Result(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  //* Método para convertir una instancia de Result a JSON.
  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}
