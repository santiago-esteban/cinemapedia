//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Crea una instancia de ActorRepositoryImpl utilizando ActorDatasourceImpl como fuente de datos.
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorDatasourceImpl());
});
