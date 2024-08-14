// Importa las pantallas de la aplicación y la librería para la gestión de rutas.
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

//* Define el enrutador principal de la aplicación.
final appRouter = GoRouter(
  initialLocation: '/', // Ubicación inicial de la aplicación.
  routes: [
    //* Ruta principal que muestra la pantalla de inicio.
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        //* Ruta secundaria para la pantalla de detalles de una película.
        GoRoute(
          path: 'movie/:id', // Parámetro dinámico para el ID de la película.
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id'; // Obtiene el ID de la película de la ruta.
            return MovieScreen(movieId: movieId); // Muestra la pantalla de la película correspondiente.
          },
        ),
      ],
    ),
  ],
);
