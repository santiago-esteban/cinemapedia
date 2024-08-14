import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Un widget que representa una barra de navegación inferior personalizada.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0, // Elimina la sombra debajo de la barra de navegación.
      currentIndex: getCurrentIndex(context),
      onTap: (index) => onItemTapped(context, index),
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
