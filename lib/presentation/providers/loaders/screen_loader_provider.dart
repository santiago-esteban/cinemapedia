import '../movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

//* Proveedor que indica si es la primera carga de datos de películas.
final screenLoaderProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty; // Verifica si la lista de películas de "ahora en cines" está vacía.
  final step2 = ref.watch(upcomingMoviesProvider).isEmpty; // Verifica si la lista de películas de "próximamente" está vacía.
  final step3 = ref.watch(popularMoviesProvider).isEmpty; // Verifica si la lista de películas populares está vacía.
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty; // Verifica si la lista de películas más valoradas está vacía.

  if (step1 || step2 || step3 || step4) return true; // Si alguna de las listas está vacía, no carga la pantalla de las películas.

  return false; // Si todas las listas tienen datos, carga la pantalla de las películas.
});
