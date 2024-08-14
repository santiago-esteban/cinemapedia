import 'package:flutter/material.dart';

//* Un widget que representa una barra de navegación inferior personalizada.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0, // Elimina la sombra debajo de la barra de navegación.
      items: const [
        //* "Inicio"
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max), // Icono para la pestaña "Inicio".
          label: 'Inicio', // Etiqueta para la pestaña "Inicio".
        ),

        //* "Categorías"
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline), // Icono para la pestaña "Categorías".
          label: 'Categorías', // Etiqueta para la pestaña "Categorías".
        ),

        //* "Favoritos"
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline), // Icono para la pestaña "Favoritos".
          label: 'Favoritos', // Etiqueta para la pestaña "Favoritos".
        ),
      ],
    );
  }
}
