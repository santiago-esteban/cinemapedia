// Importa las pantallas de la aplicación y la librería para la gestión de rutas.
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

//* Define el enrutador principal de la aplicación.
final appRouter = GoRouter(
  initialLocation: '/home/0', // Ubicación inicial de la aplicación.
  routes: [
    //* Ruta principal que muestra la pantalla de inicio.
    GoRoute(
      path: '/home/:page', // Ruta que incluye un parámetro dinámico 'page'.
      name: HomeScreen.name, // Nombre de la ruta (Opcional).
      builder: (context, state) {
        int pageIndex = int.parse(state.pathParameters['page'] ?? '0'); // Convierte el parámetro 'page' a un entero.
        if (pageIndex < 0 || pageIndex > 2) pageIndex = 0; // Valida que el índice esté dentro de un rango válido.
        return HomeScreen(pageIndex: pageIndex); // Retorna la pantalla de inicio con el índice de página correspondiente.
      },
      routes: [
        //* Ruta secundaria para la pantalla de detalles de una película.
        GoRoute(
          path: 'movie/:id', // Parámetro dinámico para el ID de la película.
          name: MovieScreen.name, // Nombre de la ruta (Opcional).
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id'; // Obtiene el ID de la película de la ruta.
            return MovieScreen(movieId: movieId); // Muestra la pantalla de la película correspondiente.
          },
        ),
      ],
    ),

    //* Redirección de la ruta raíz '/' a la ubicación inicial.
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0', // Redirige a la pantalla inicial de la aplicación.
    )
  ],
);
