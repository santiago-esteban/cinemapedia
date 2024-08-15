import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de estado para la instancia de MovieRepositoryImpl.
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDatasourceImpl()); // Crea una instancia de MovieRepositoryImpl que utiliza MovieDatasourceImpl para obtener datos.
});
