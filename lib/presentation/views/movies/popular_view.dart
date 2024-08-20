//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Vista de la pantalla de películas populares.
class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

//* Clase PopularViewState que maneja el estado de PopularView. Usa AutomaticKeepAliveClientMixin para mantener el estado.
class PopularViewState extends ConsumerState<PopularView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    //* El widget MovieMasonry muestra las películas populares.
    return Scaffold(
      body: MovieMasonry(
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
