//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Vista de la pantalla de inicio.
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

//* Estado para manejar la lógica y la interfaz de HomeView.
class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    //* Carga la primera página de cada lista de películas al inicializar el estado.
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenLoader = ref.watch(screenLoaderProvider);
    if (screenLoader) return const CustomScreenLoader();

    //* Observa las películas desde los proveedores.
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: CustomAppbar(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  //* Carrusel de 10 peliculas
                  MoviesSlideshow(movies: slideShowMovies),

                  //* Listas de películas "infinitas".
                  MoviesListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: Formats.formatDate(DateTime.now()),
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesListview(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    subTitle: 'Este mes',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
