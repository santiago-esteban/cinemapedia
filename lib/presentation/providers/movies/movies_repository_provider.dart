import 'package:cinemapedia/infrastructure/datasources/movie_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

//* Proveedor de estado para la instancia de MovieRepositoryImpl.
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDatasourceImpl()); // Crea una instancia de MovieRepositoryImpl que utiliza MovieDatasourceImpl para obtener datos.
});
