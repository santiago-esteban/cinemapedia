// Importa la librería necesaria para manejar temas en Flutter.
import 'package:flutter/material.dart';

//* Clase que define el tema visual de la aplicación.
class AppTheme {
  //* Método que devuelve la configuración del tema.
  ThemeData getTheme() => ThemeData(
      useMaterial3: true, // Activa el uso de Material Design 3.
      colorSchemeSeed: Colors.white, // Color principal de la aplicación.
      brightness: Brightness.dark);
}
