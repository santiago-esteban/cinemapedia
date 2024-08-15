import 'package:cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isarRepositoryProvider = Provider((ref) {
  return IsarRepositoryImpl(datasource: IsarDatasourceImpl());
});
