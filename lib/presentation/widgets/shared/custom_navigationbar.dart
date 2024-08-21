//* Importaciones de paquetes necesarios.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Widget personalizado que representa una barra de navegación inferior
class CustomNavigationbar extends StatelessWidget {
  //* Índice que indica la vista seleccionada actualmente
  final int currentIndex;

  const CustomNavigationbar({
    super.key,
    required this.currentIndex,
  });

  //* Maneja la navegación cuando se selecciona un ítem de la barra
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0'); //* Navega a la vista "Inicio"
        break;
      case 1:
        context.go('/home/1'); //* Navega a la vista "Populares"
        break;
      case 2:
        context.go('/home/2'); //* Navega a la vista "Favoritos"
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex, //* Marca la vista seleccionada actualmente
      onDestinationSelected: (value) => onItemTapped(context, value), //* Navega a la vista seleccionada
      elevation: 0,
      destinations: const [
        //* Ítem "Inicio"
        NavigationDestination(icon: Icon(Icons.home_max), label: 'Inicio'),

        //* Ítem "Populares"
        NavigationDestination(icon: Icon(Icons.thumbs_up_down_outlined), label: 'Populares'),

        //* Ítem "Favoritos"
        NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
