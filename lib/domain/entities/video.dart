//* Clase que representa un video relacionado con una película.
class Video {
  final String id;
  final String name;
  final String youtubeKey;
  final DateTime publishedAt;

  //* Constructor para crear una instancia de `Video`.
  Video({
    required this.id,
    required this.name,
    required this.youtubeKey,
    required this.publishedAt,
  });
}
