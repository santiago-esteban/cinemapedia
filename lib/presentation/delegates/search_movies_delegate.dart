import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Tipo de función para buscar películas basado en una consulta.
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

//* Delegate personalizado para la búsqueda de películas en la aplicación.
class SearchMoviesDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  //* Controladores de stream para manejar el estado de carga y las películas encontradas.
  StreamController<List<Movie>> debouncedMoviesStream = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debouncedTimer;

  //* Constructor que inicializa la función de búsqueda y las películas iniciales.
  SearchMoviesDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar películas');

  @override
  void dispose() {
    _debouncedTimer?.cancel();
    debouncedMoviesStream.close();
    isLoadingStream.close();
    super.dispose();
  }

  //* Método que maneja los cambios en la consulta de búsqueda.
  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    if (_debouncedTimer?.isActive ?? false) {
      _debouncedTimer!.cancel();
    }
    //* Configura un nuevo temporizador para retrasar la búsqueda y reducir la cantidad de solicitudes HTTP.
    _debouncedTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMoviesStream.add(movies);
      isLoadingStream.add(false);
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
        close(context, null);
        _debouncedTimer?.cancel();
        isLoadingStream.close();
        debouncedMoviesStream.close();
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
  const _StreamBuilder({
    required this.initialMovies,
    required this.debouncedMoviesStream,
  });

  final List<Movie> initialMovies;
  final StreamController<List<Movie>> debouncedMoviesStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMoviesStream.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        );
      },
    );
  }
}

//* Widget para construir un ítem de película individual en la lista.
class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => context.go('/home/0/movie/${movie.id}'),
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              //* Imagen de la película
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.posterPath),
                    placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              //* Descripción de la película
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Título y descripción breve
                    Text(movie.title, style: textStyles.titleMedium),
                    (movie.overview.length > 100) ? Text('${movie.overview.substring(0, 100)}...') : Text(movie.overview),

                    //* Estrella y valoraciones
                    Row(
                      children: [
                        Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                        const SizedBox(width: 5),
                        Text(Formats.number(movie.voteAverage, 1), style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
