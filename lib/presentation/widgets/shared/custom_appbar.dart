//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Representa la barra de aplicaciones en la parte superior
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          //* Ocupa todo el ancho disponible
          width: double.infinity,
          child: Row(
            children: [
              //* Icono de la aplicación
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              //* Título de la aplicación
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  //* Inicia la búsqueda de películas
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMoviesDelegate(initialMovies: searchedMovies, searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery),
                  );
                },
                //* Icono de búsqueda
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
