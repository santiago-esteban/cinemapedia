//* Clase que representa los detalles de una película.
class DetailsResponse {
  final bool adult; // Indica si la película es solo para adultos.
  final String backdropPath; // Ruta del fondo de la película.
  final BelongsToCollection? belongsToCollection; // Colección a la que pertenece la película, si aplica.
  final int budget; // Presupuesto de la película.
  final List<Genre> genres; // Lista de géneros a los que pertenece la película.
  final String homepage; // Página web oficial de la película.
  final int id; // Identificador único de la película.
  final String? imdbId; // Identificador en IMDb, si existe.
  final List<String>? originCountry; // Lista de países de origen.
  final String originalLanguage; // Idioma original de la película.
  final String originalTitle; // Título original de la película.
  final String overview; // Resumen de la trama de la película.
  final double popularity; // Popularidad de la película.
  final String posterPath; // Ruta del póster de la película.
  final List<ProductionCompany> productionCompanies; // Compañías productoras de la película.
  final List<ProductionCountry> productionCountries; // Países donde se produjo la película.
  final DateTime? releaseDate; // Fecha de estreno de la película.
  final int revenue; // Ingresos generados por la película.
  final int runtime; // Duración de la película en minutos.
  final List<SpokenLanguage> spokenLanguages; // Idiomas hablados en la película.
  final String status; // Estado actual de la película (por ejemplo, 'Released').
  final String tagline; // Lema o frase promocional de la película.
  final String title; // Título de la película.
  final bool video; // Indica si la película es un video.
  final double voteAverage; // Promedio de valoraciones de la película.
  final int voteCount; // Número de valoraciones que ha recibido la película.

  DetailsResponse({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  //* Método para crear una instancia de DetailsResponse a partir de un JSON.
  factory DetailsResponse.fromJson(Map<String, dynamic> json) => DetailsResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? '',
        belongsToCollection: json["belongs_to_collection"] == null ? null : BelongsToCollection.fromJson(json["belongs_to_collection"]),
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"] ?? '',
        originCountry: json["origin_country"] != null ? List<String>.from(json["origin_country"].map((x) => x)) : null,
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? '',
        productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] != null ? DateTime.tryParse(json["release_date"]) : null,
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  //* Método para convertir una instancia de DetailsResponse a JSON.
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection?.toJson(),
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "origin_country": originCountry != null ? List<dynamic>.from(originCountry!.map((x) => x)) : null,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "release_date": releaseDate != null ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}" : null,
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

//* Clase que representa una colección a la que pertenece la película, como una saga o serie de películas.
class BelongsToCollection {
  final int id; // Identificador único de la colección.
  final String name; // Nombre de la colección.
  final String posterPath; // Ruta del póster de la colección.
  final String backdropPath; // Ruta del fondo de la colección.

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  // Método para crear una instancia de BelongsToCollection a partir de un JSON.
  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"] ?? '',
        backdropPath: json["backdrop_path"] ?? '',
      );

  // Método para convertir una instancia de BelongsToCollection a JSON.
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
      };
}

//* Clase que representa un género al que pertenece la película.
class Genre {
  final int id; // Identificador único del género.
  final String name; // Nombre del género.

  Genre({
    required this.id,
    required this.name,
  });

  // Método para crear una instancia de Genre a partir de un JSON.
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  // Método para convertir una instancia de Genre a JSON.
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

//* Clase que representa una compañía productora de la película.
class ProductionCompany {
  final int id; // Identificador único de la compañía.
  final String? logoPath; // Ruta del logo de la compañía, si está disponible.
  final String name; // Nombre de la compañía.
  final String originCountry; // País de origen de la compañía.

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  // Método para crear una instancia de ProductionCompany a partir de un JSON.
  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  // Método para convertir una instancia de ProductionCompany a JSON.
  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

//* Clase que representa un país donde se produjo la película.
class ProductionCountry {
  final String iso31661; // Código ISO 3166-1 del país.
  final String name; // Nombre del país.

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  // Método para crear una instancia de ProductionCountry a partir de un JSON.
  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  // Método para convertir una instancia de ProductionCountry a JSON.
  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

//* Clase que representa un idioma hablado en la película.
class SpokenLanguage {
  final String englishName; // Nombre del idioma en inglés.
  final String iso6391; // Código ISO 639-1 del idioma.
  final String name; // Nombre del idioma en su forma nativa.

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  // Método para crear una instancia de SpokenLanguage a partir de un JSON.
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  // Método para convertir una instancia de SpokenLanguage a JSON.
  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
