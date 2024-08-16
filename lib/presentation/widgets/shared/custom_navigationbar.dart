import 'package:flutter/material.dart'; // Importa los widgets principales de Flutter.
import 'package:go_router/go_router.dart'; // Importa GoRouter para la gestión de rutas.

//* Un widget que representa una barra de navegación inferior personalizada.
class CustomNavigationbar extends StatelessWidget {
  final int currentIndex; // Índice actual que determina la vista seleccionada.

  const CustomNavigationbar({
    super.key,
    required this.currentIndex, // El índice actual es requerido al crear la barra de navegación.
  });

  //* Método que maneja el toque en un ítem de la barra de navegación.
  void onItemTapped(BuildContext context, int index) {
    context.go('home/$index'); // Navega a la ruta correspondiente según el índice.
    switch (index) {
      case 0:
        context.go('/home/0'); // Navega a la vista "Inicio".
        break;
      case 1:
        context.go('/home/1'); // Navega a la vista "Categorías".
        break;
      case 2:
        context.go('/home/2'); // Navega a la vista "Favoritos".
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex, // Establece la vista seleccionada actualmente.
      onDestinationSelected: (value) => onItemTapped(context, value), // Llama al método onItemTapped cuando se toca una vista.
      elevation: 0, // Elimina la sombra debajo de la barra de navegación.
      destinations: const [
        //* "Inicio"
        NavigationDestination(
          icon: Icon(Icons.home_max), // Icono para la vista "Inicio".
          label: 'Inicio', // Etiqueta para la vista "Inicio".
        ),

        //* "Categorías"
        NavigationDestination(
          icon: Icon(Icons.label_outline), // Icono para la vista "Categorías".
          label: 'Categorías', // Etiqueta para la vista "Categorías".
        ),

        //* "Favoritos"
        NavigationDestination(
          icon: Icon(Icons.favorite_outline), // Icono para la vista "Favoritos".
          label: 'Favoritos', // Etiqueta para la vista "Favoritos".
        ),
      ],
    );
  }
}
