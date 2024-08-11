import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsMovieProvider =
    StateNotifierProvider<ActorsMovieProvider, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider).getActorByMovie;
  return ActorsMovieProvider(actorsRepository);
});

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorsMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;
  ActorsMovieProvider(this.getActors) : super({});

  Future<void> loadActors({required String movieId}) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
