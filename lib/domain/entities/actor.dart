//* Clase que representa a un actor en la aplicación.
class Actor {
  final int id; // Identificador único del actor.
  final String name; // Nombre del actor.
  final String profilePath; // Ruta de la imagen del actor.
  final String? character; // Nombre del personaje interpretado por el actor (opcional).

  //* Constructor para crear una instancia de 'Actor'. Todos los parámetros son obligatorios, excepto `character`, que es opcional.
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });
}
