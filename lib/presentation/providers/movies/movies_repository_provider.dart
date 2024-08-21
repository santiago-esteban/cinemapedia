//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Crea una instancia de MovieRepositoryImpl que utiliza MovieDatasourceImpl para obtener datos
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDatasourceImpl());
});
