//* Vista principal dentro de la pantalla de inicio.
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/presentation/presentation.dart'; // Importa los proveedores de estado.
import 'package:flutter/material.dart'; // Importa los widgets de Flutter.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key}); // Constructor.

  @override
  HomeViewState createState() => HomeViewState(); // Crea el estado asociado con esta vista.
}

//* Estado para manejar la lógica y la interfaz de HomeView.
class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // Carga la primera página de cada lista de películas al inicializar el estado.
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenLoader = ref.watch(screenLoaderProvider); // Verifica si es la primera carga de datos.
    if (screenLoader) return const CustomScreenLoader(); // Muestra un cargador a pantalla completa si los datos aún están cargándose.

    final slideShowMovies = ref.watch(moviesSlideshowProvider); // Obtiene las películas para el carrusel.
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); // Obtiene las películas actualmente en cartelera.
    final upcomingMovies = ref.watch(upcomingMoviesProvider); // Obtiene las películas próximas a estrenarse.
    final topRatedMovies = ref.watch(topRatedMoviesProvider); // Obtiene las películas mejor calificadas.

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true, // Mantiene la AppBar flotante.
          flexibleSpace: CustomAppbar(), // Barra de aplicación personalizada.
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  //* Carrusel de 6 peliculas
                  MoviesSlideshow(movies: slideShowMovies), // Muestra el carrusel de películas.

                  //* Listas de películas "infinitas".
                  MoviesListview(
                    movies: nowPlayingMovies, // Lista de películas en cartelera.
                    title: 'En cines',
                    subTitle: Formats.formatDate(DateTime.now()),
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(), // Función para cargar más películas al final.
                  ),
                  MoviesListview(
                    movies: upcomingMovies, // Lista de películas próximas.
                    title: 'Próximamente',
                    subTitle: 'Este mes',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesListview(
                    movies: topRatedMovies, // Lista de películas mejor calificadas.
                    title: 'Mejor calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),
                  const SizedBox(height: 20) // Espaciado al final de la lista.
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
