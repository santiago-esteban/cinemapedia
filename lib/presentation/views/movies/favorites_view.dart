//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//* Vista de la pantalla de películas favoritas.
class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  //* Carga la siguiente página de películas favoritas.
  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(isarFavoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //* Observa las películas favoritas desde el proveedor.
    final favoritesMovies = ref.watch(isarFavoriteMoviesProvider).values.toList();

    //* Verifica si no hay películas favoritas.
    if (favoritesMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* Elementos mostrados en la pantalla cuando no hay películas favoritas.
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('¡Ohh no!', style: TextStyle(fontSize: 30, color: colors.primary)),
            Text('¡No tienes películas favoritas!', style: TextStyle(fontSize: 20, color: colors.primary)),
            const SizedBox(height: 20),
            FilledButton.tonal(onPressed: () => context.go('/home/0'), child: const Text('Buscar mis favoritas')),
          ],
        ),
      );
    }

    //* Muestra la lista de películas favoritas.
    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: favoritesMovies),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
