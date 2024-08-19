//* Importa la librería para la navegación con rutas.
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

//* Configuración del enrutador de la aplicación.
final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    //* Ruta principal para la pantalla de inicio.
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        //* Ruta anidada para la pantalla de detalles de una película.
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    //* Redirección de la ruta raíz a la pantalla de inicio.
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    ),
  ],
);
