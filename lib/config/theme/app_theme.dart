//* Importa la librería necesaria para manejar temas.
import 'package:flutter/material.dart';

//* Clase que define el tema visual de la aplicación.
class AppTheme {
  //* Configuración del tema.
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.white,
      );
}
