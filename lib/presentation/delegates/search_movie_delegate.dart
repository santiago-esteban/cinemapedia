import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

//* Tipo de función para buscar películas basado en una consulta.
typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

//* Delegate personalizado para la búsqueda de películas en la aplicación.
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies; // Referencia a la función para realizar la búsqueda de películas.
  List<Movie> initialMovies; // Lista inicial de películas que se mostrará antes de realizar la búsqueda.

  //* Controladores de stream para manejar el estado de carga y las películas encontradas.
  StreamController<List<Movie>> debouncedMoviesStream = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debouncedTimer; // Temporizador para implementar el debounce en las búsquedas.

  //* Constructor que inicializa la función de búsqueda y las películas iniciales.
  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar película');

  //* Método que maneja los cambios en la consulta de búsqueda.
  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true); // Muestra el indicador de carga si la consulta no está vacía.
    if (_debouncedTimer?.isActive ?? false) {
      _debouncedTimer!.cancel(); // Cancela el temporizador anterior si está activo.
    }
    // Configura un nuevo temporizador para retrasar la búsqueda y reducir la cantidad de solicitudes HTTP.
    _debouncedTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query); // Realiza la búsqueda de películas.
      initialMovies = movies; // Actualiza las películas iniciales.
      isLoadingStream.add(false); // Oculta el indicador de carga.
      debouncedMoviesStream.add(movies); // Agrega las películas encontradas al stream.
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    //* Construye los botones de acción en la barra de búsqueda.
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            //* Muestra un botón de refresco animado si se está cargando.
            return SpinPerfect(
              duration: const Duration(seconds: 5),
              spins: 10,
              infinite: true,
              child: IconButton(onPressed: () => query = '', icon: const Icon(Icons.refresh_rounded)),
            );
          }
          //* Muestra un botón para borrar la consulta si no se está cargando.
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //* Construye el botón para cerrar el search delegate.
    return IconButton(
      onPressed: () {
        close(context, null); // Cierra la búsqueda y pasa null como resultado.
        _debouncedTimer?.cancel(); // Cancela el temporizador.
        isLoadingStream.close(); // Cierra el stream de carga.
        debouncedMoviesStream.close(); // Cierra el stream de películas.
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //* Construye la vista para mostrar los resultados de la búsqueda.
    return _StreamBuilder(initialMovies: initialMovies, debouncedMoviesStream: debouncedMoviesStream);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //* Llama a _onQueryChanged para actualizar las sugerencias en función de la consulta actual.
    _onQueryChanged(query);
    return _StreamBuilder(initialMovies: initialMovies, debouncedMoviesStream: debouncedMoviesStream);
  }
}

//* Widget para construir la lista de películas usando un StreamBuilder.
class _StreamBuilder extends StatelessWidget {
  // Constructor del widget que recibe la lista inicial de películas y el StreamController.
  const _StreamBuilder({
    required this.initialMovies,
    required this.debouncedMoviesStream,
  });

  final List<Movie> initialMovies; // Lista de películas que se mostrará inicialmente antes de que se actualice con los datos del stream.
  final StreamController<List<Movie>> debouncedMoviesStream; // Controlador de flujo que proporciona las películas actualizadas basadas en la consulta de búsqueda.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies, // Establece la lista inicial de películas como datos iniciales del StreamBuilder.
      stream: debouncedMoviesStream.stream, // Proporciona el flujo de datos de películas que el StreamBuilder escuchará.
      builder: (context, snapshot) {
        final movies = snapshot.data ?? []; // Obtiene las películas del snapshot de datos del stream. Si no hay datos, usa una lista vacía.
        return ListView.builder(
          itemCount: movies.length, // Construye la lista de películas con el número de ítems determinado por la longitud de la lista de películas.
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]), // Construye cada ítem de película utilizando el widget _MovieItem.
        );
      },
    );
  }
}

//* Widget para construir un ítem de película individual en la lista.
class _MovieItem extends StatelessWidget {
  final Movie movie; // Película que se mostrará en este ítem.

  const _MovieItem({required this.movie}); // Constructor que recibe una instancia de Movie.

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme; // Obtiene los estilos de texto del tema actual.
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla para ajustar el diseño.

    return GestureDetector(
      onTap: () => context.go('/home/0/movie/${movie.id}'), // Navega a la página individual de la película al tocar el ítem.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //* Imagen de la película
            SizedBox(
              width: size.width * 0.2, // Define el ancho del contenedor de la imagen.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Redondea las esquinas de la imagen.
                child: Image.network(
                  movie.posterPath, // Ruta del póster de la película.
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(
                      child: child, // Muestra una animación de desvanecimiento mientras se carga la imagen.
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10), // Espacio entre la imagen y la descripción.
            //* Descripción de la película
            SizedBox(
              width: size.width * 0.7, // Define el ancho del contenedor de la descripción.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto al principio de la columna.
                children: [
                  //* Título y descripción breve
                  Text(movie.title, style: textStyles.titleMedium), // Muestra el título de la película con el estilo definido.
                  // Muestra una descripción breve de la película. Si es demasiado larga, la trunca y añade "..." al final.
                  (movie.overview.length > 100) ? Text('${movie.overview.substring(0, 100)}...') : Text(movie.overview),

                  //* Estrella y valoraciones
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800), // Muestra un ícono de estrella para las valoraciones.
                      const SizedBox(width: 5), // Espacio entre la estrella y la calificación.
                      Text(
                        HumanFormats.number(movie.voteAverage, 1), // Muestra la calificación de la película formateada.
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
