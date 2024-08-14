import 'package:flutter/material.dart'; // Importa los widgets de Flutter.
import 'package:cinemapedia/presentation/widgets/widgets.dart'; // Importa los widgets personalizados.

//* Pantalla principal que muestra la interfaz de inicio de la aplicación.
class HomeScreen extends StatelessWidget {
  static const name = 'home-screen'; // Nombre de la ruta para navegación.

  final Widget childView;

  const HomeScreen({
    super.key,
    required this.childView,
  }); // Constructor con clave opcional.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView, // Cuerpo de la pantalla, que muestra la vista principal.
      bottomNavigationBar: const CustomNavigationBar(), // Barra de navegación personalizada de la parte inferior.
    );
  }
}
