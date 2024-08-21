//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor que determina si es la primera vez que se cargan los datos de películas
final screenLoaderProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step3 = ref.watch(popularMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true; //* Retorna `true` si alguna lista está vacía, indicando que la carga inicial no está completa

  return false; //* Retorna `false` si todas las listas tienen datos, indicando que la carga inicial está completa
});
