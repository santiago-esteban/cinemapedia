import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Un widget personalizado que representa la barra de aplicaciones de la parte superior.
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme; // Obtiene los colores del tema actual.
    final titleStyle = Theme.of(context).textTheme.titleMedium; // Obtiene el estilo del texto para el título.

    return SafeArea(
      bottom: false, // Evita el uso del área segura en la parte inferior.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // Aplica un padding horizontal a la barra.
        child: SizedBox(
          width: double.infinity, // Hace que el contenedor ocupe todo el ancho disponible.
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary), // Icono de película con color del tema.
              const SizedBox(width: 5), // Espacio horizontal entre el icono y el texto.
              Text('Cinemapedia', style: titleStyle), // Título de la aplicación con el estilo de texto especificado.
              const Spacer(), // Espacio flexible que empuja el contenido a la izquierda.
              IconButton(
                onPressed: () {
                  //* Obtiene la lista de películas buscadas.
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  //* Obtiene la consulta de búsqueda actual.
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch(
                    query: searchQuery, // Inicializa la búsqueda con la consulta actual.
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies, // Proporciona las películas iniciales para la búsqueda.
                      //* Funcionalidad que conserva la query de búsqueda en el label al salir del SearchMovieDelegate
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery, // Función de búsqueda que actualiza la lista de películas según la consulta.
                    ),
                  );
                },
                icon: const Icon(Icons.search), // Icono de búsqueda en la barra de aplicaciones.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
