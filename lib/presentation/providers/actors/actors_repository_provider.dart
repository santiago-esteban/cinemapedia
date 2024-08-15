import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de instancia para el repositorio de actores.
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorDatasourceImpl()); // Crea una instancia de ActorRepositoryImpl utilizando ActorDatasourceImpl como fuente de datos.
});
