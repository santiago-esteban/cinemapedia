//* Clase que representa a un actor en la aplicación.
class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;

  //* Constructor para crear una instancia de 'Actor'.
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
  });
}
