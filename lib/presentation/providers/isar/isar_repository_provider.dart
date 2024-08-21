//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor que crea una instancia de IsarRepositoryImpl, utilizando IsarDatasourceImpl como fuente de datos
final isarRepositoryProvider = Provider((ref) {
  return IsarRepositoryImpl(datasource: IsarDatasourceImpl());
});
