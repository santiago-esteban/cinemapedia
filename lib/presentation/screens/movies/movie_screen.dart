//* Importaciones de paquetes necesarios.
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Pantalla que muestra los detalles de una película.
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    //* Carga de los detalles de la película y actores al iniciar la pantalla.
    ref.read(movieDetailsProvider.notifier).loadMovie(movieId: widget.movieId);
    ref.read(actorsMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    //* Observa los detalles de la película.
    final Movie? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      //* Estructura de la pantalla con scroll y barra de aplicación personalizada.
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => _MovieDetails(movie: movie), childCount: 1)),
        ],
      ),
    );
  }
}

//* Widget que muestra los detalles de la película.
class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Título, Descripción y Rating de la película.
        _TitleAndOverview(movie: movie, size: size, textStyles: textStyles),

        //* Géneros de la película.
        _Genres(movie: movie),

        //* Actores que participaron en la película.
        ActorsByMovie(movieId: movie.id.toString()),

        //* Videos relacionados con la película (si tiene).
        MovieVideo(movieId: movie.id),

        //* Películas similares a la actual.
        MoviesSimilar(movieId: movie.id),

        const SizedBox(height: 10),
      ],
    );
  }
}

//* Widget que muestra los géneros de la película.
class _Genres extends StatelessWidget {
  const _Genres({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            //* Chips que muestran cada género de la película.
            ...movie.genreIds.map(
              (gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//* Widget que muestra el título y la descripción de la película.
class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen de la película.
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
            ),
          ),
          const SizedBox(width: 10),
          //* Descripción de la película.
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleLarge),
                Text(movie.overview),
                const SizedBox(height: 10),
                MovieRating(voteAverage: movie.voteAverage),
                Row(
                  children: [
                    const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text(Formats.shortDate(movie.releaseDate)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//* Proveedor para verificar si la película es favorita.
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(isarRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

//* Barra de aplicación personalizada que incluye la imagen de la película y un botón para marcarla como favorita.
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref.read(isarFavoriteMoviesProvider.notifier).toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite ? const Icon(Icons.favorite_rounded, color: Colors.red) : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        //* Gradiente personalizado para efectos visuales en la barra de aplicación.
        title: _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();
                return FadeIn(child: child);
              }),
            ),
            //* Gradiente para fondo de la barra de favoritos.
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            //* Gradiente para el fondo de la flecha de retroceso.
            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

//* Widget para crear un gradiente personalizado.
class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: begin, end: end, stops: stops, colors: colors),
        ),
      ),
    );
  }
}
