//* Importa la librería para manejar variables de entorno.
import 'package:flutter_dotenv/flutter_dotenv.dart';

//* Clase que maneja las variables de entorno de la aplicación.
class Environment {
  //* Obtiene la clave de API desde las variables de entorno, con un valor por defecto si no se encuentra.
  static String tmdbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay API Key';
}
