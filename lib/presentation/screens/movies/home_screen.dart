import 'package:flutter/material.dart'; // Importa los widgets de Flutter.
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart'; // Importa los widgets personalizados.
import 'package:cinemapedia/presentation/providers/providers.dart'; // Importa los proveedores de estado.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

//* Pantalla principal que muestra la interfaz de inicio de la aplicación.
class HomeScreen extends StatelessWidget {
  static const name = 'home-screen'; // Nombre de la ruta para navegación.

  const HomeScreen({super.key}); // Constructor con clave opcional.

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(), // Cuerpo de la pantalla, que muestra la vista principal.
      bottomNavigationBar: CustomNavigationBar(), // Barra de navegación personalizada de la parte inferior.
    );
  }
}

//* Vista principal dentro de la pantalla de inicio.
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView(); // Constructor.

  @override
  _HomeViewState createState() => _HomeViewState(); // Crea el estado asociado con esta vista.
}

//* Estado para manejar la lógica y la interfaz de _HomeView.
class _HomeViewState extends ConsumerState<_HomeView> {
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
    final firstLoading = ref.watch(firstLoadingProvider); // Verifica si es la primera carga de datos.
    if (firstLoading) return const FullScreenLoader(); // Muestra un cargador a pantalla completa si los datos aún están cargándose.

    final slideShowMovies = ref.watch(moviesSlideshowProvider); // Obtiene las películas para el carrusel.
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); // Obtiene las películas actualmente en cartelera.
    final upcomingMovies = ref.watch(upcomingMoviesProvider); // Obtiene las películas próximas a estrenarse.
    final popularMovies = ref.watch(popularMoviesProvider); // Obtiene las películas más populares.
    final topRatedMovies = ref.watch(topRatedMoviesProvider); // Obtiene las películas mejor calificadas.

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true, // Mantiene la AppBar flotante.
          flexibleSpace: CustomAppbar(), // Barra de aplicación personalizada.
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //* Carrusel de 6 peliculas
                MoviesSlideshow(movies: slideShowMovies), // Muestra el carrusel de películas.

                //* Listas de películas "infinitas".
                MoviesListview(
                  movies: nowPlayingMovies, // Lista de películas en cartelera.
                  title: 'En cines',
                  subTitle: HumanFormats.formatDate(DateTime.now()),
                  loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(), // Función para cargar más películas al final.
                ),
                MoviesListview(
                  movies: upcomingMovies, // Lista de películas próximas.
                  title: 'Próximamente',
                  subTitle: 'Este mes',
                  loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesListview(
                  movies: popularMovies, // Lista de películas populares.
                  title: 'Populares',
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
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
          }, childCount: 1),
        ),
      ],
    );
  }
}
