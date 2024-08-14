//* Clase que representa la respuesta obtenida del API al solicitar los créditos de una película,
class CreditsResponse {
  final int id; // Identificador único de la película.
  final List<Cast> cast; // Lista de actores que participaron en la película.
  final List<Cast> crew; // Lista de miembros del equipo técnico de la película.

  CreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  // Método para crear una instancia de CreditsResponse a partir de un JSON.
  factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(
            json["cast"].map((x) => Cast.fromJson(x))), // Convierte el JSON de actores en una lista de objetos Cast.
        crew: List<Cast>.from(json["crew"]
            .map((x) => Cast.fromJson(x))), // Convierte el JSON del equipo técnico en una lista de objetos Cast.
      );

  // Método para convertir una instancia de CreditsResponse a JSON.
  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())), // Convierte la lista de actores a JSON.
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())), // Convierte la lista del equipo técnico a JSON.
      };
}

//* Clase que representa a una persona involucrada en la producción de una película.
class Cast {
  final bool adult; // Indica si la persona es adulta.
  final int gender; // Género de la persona.
  final int id; // Identificador único de la persona.
  final String
      knownForDepartment; // Departamento o rol por el que es conocida la persona (por ejemplo, actuación, dirección).
  final String name; // Nombre de la persona.
  final String originalName; // Nombre original de la persona.
  final double popularity; // Popularidad de la persona.
  final String? profilePath; // Ruta de la imagen de perfil de la persona, si está disponible.
  final int? castId; // Identificador del rol de actuación.
  final String? character; // Nombre del personaje interpretado por el actor.
  final String creditId; // Identificador único del crédito.
  final int? order; // Orden en que aparece la persona en los créditos.
  final String? department; // Departamento en el que trabaja la persona.
  final String? job; // Trabajo específico realizado por la persona.

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  // Método para crear una instancia de Cast a partir de un JSON.
  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );

  // Método para convertir una instancia de Cast a JSON.
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
      };
}
