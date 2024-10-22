//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor que gestiona la lista de actores por película
final actorsMovieProvider = StateNotifierProvider<ActorsMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsMovieNotifier(getActors: actorsRepository.getActorByMovie);
});

//* Función para obtener actores basado en el ID de la película
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

//* Notifier que maneja el estado de los actores para una película específica
class ActorsMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsMovieNotifier({
    required this.getActors,
  }) : super({}); //* Inicializa el estado como un mapa vacío

  //* Carga los actores para una película específica si aún no están en el estado
  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return; //* Evita recargar si ya se han cargado los actores para esa película

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors}; //* Actualiza el estado con la lista de actores
  }
}
