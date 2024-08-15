import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Proveedor de estado para manejar la lista de actores por película.
final actorsProvider = StateNotifierProvider<ActorsMovieProvider, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider).getActorByMovie; // Obtiene la función getActorByMovie del repositorio de actores.
  return ActorsMovieProvider(actorsRepository); // Crea una instancia de ActorsMovieProvider con la función de obtención de actores.
});

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId); // Tipo de callback para obtener una lista de actores dado un ID de película.

//* Clase que maneja el estado de los actores para diferentes películas.
class ActorsMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors; // Función de callback para obtener actores basado en el ID de la película.

  ActorsMovieProvider(this.getActors) : super({}); // Constructor que inicializa el estado con un mapa vacío.

  //* Método para cargar actores para una película específica.
  Future<void> loadActors({required String movieId}) async {
    if (state[movieId] != null) return; // Verifica si los actores para la película ya están cargados.
    final List<Actor> actors = await getActors(movieId); // Obtiene la lista de actores llamando a la función getActors.
    state = {...state, movieId: actors}; // Actualiza el estado con la lista de actores para la película dada.
  }
}
