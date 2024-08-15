import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';

//* Pantalla principal que muestra la interfaz de inicio de la aplicación.
class HomeScreen extends StatelessWidget {
  static const name = 'home-screen'; // Nombre constante para identificar la pantalla.
  final int pageIndex; // Índice de la página que se debe mostrar.

  const HomeScreen({
    super.key,
    required this.pageIndex, // El índice de la página es requerido al crear una instancia de HomeScreen.
  });

  //* Lista de vistas que se pueden mostrar en la pantalla de inicio.
  final viewRoutes = const <Widget>[
    HomeView(), // Vista principal de inicio.
    CategoriesView(), // Vista de categorías.
    FavoritesView(), // Vista de favoritos.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Cuerpo de la pantalla, que muestra la vista correspondiente al índice actual.
      body: IndexedStack(
        index: pageIndex, // El índice determina cuál vista se muestra.
        children: viewRoutes, // Lista de vistas disponibles.
      ),
      //* Barra de navegación personalizada en la parte inferior de la pantalla.
      bottomNavigationBar: CustomNavigationbar(currentIndex: pageIndex),
    );
  }
}
