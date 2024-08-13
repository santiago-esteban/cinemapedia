import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMoviesStream = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debouncedTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar película');

  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    if (_debouncedTimer?.isActive ?? false) {
      _debouncedTimer!.cancel();
    }
    _debouncedTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      isLoadingStream.add(false);
      debouncedMoviesStream.add(movies);
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 5),
              spins: 10,
              infinite: true,
              child: IconButton(onPressed: () => query = '', icon: const Icon(Icons.refresh_rounded)),
            );
          }
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
    return _StreamBuilder(initialMovies: initialMovies, debouncedMoviesStream: debouncedMoviesStream);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _StreamBuilder(initialMovies: initialMovies, debouncedMoviesStream: debouncedMoviesStream);
  }
}

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

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => context.go('/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //*Imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(
                      child: child,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            //*Descripción
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*Texto y descripción breve
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100) ? Text('${movie.overview.substring(0, 100)}...') : Text(movie.overview),

                  //*Estrella y valoraciones
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
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
