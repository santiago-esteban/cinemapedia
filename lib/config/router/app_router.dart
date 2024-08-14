// Importa las pantallas de la aplicación y la librería para la gestión de rutas.
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

//* Define el enrutador principal de la aplicación.
final appRouter = GoRouter(
  initialLocation: '/', // Ubicación inicial de la aplicación.
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id', // Parámetro dinámico para el ID de la película.
                name: MovieScreen.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id'; // Obtiene el ID de la película de la ruta.
                  return MovieScreen(movieId: movieId); // Muestra la pantalla de la película correspondiente.
                },
              ),
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        )
      ],
    )

    //! RUTAS PADRE/HIJO
    // //* Ruta principal que muestra la pantalla de inicio.
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: FavoritesView()),
    //   routes: [
    //     //* Ruta secundaria para la pantalla de detalles de una película.
    //     GoRoute(
    //       path: 'movie/:id', // Parámetro dinámico para el ID de la película.
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id'; // Obtiene el ID de la película de la ruta.
    //         return MovieScreen(movieId: movieId); // Muestra la pantalla de la película correspondiente.
    //       },
    //     ),
    //   ],
    // ),
  ],
);
