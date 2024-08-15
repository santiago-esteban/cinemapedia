import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Pantalla principal para mostrar la información de una película.
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen'; // Nombre de la ruta para navegación.
  final String movieId; // ID de la película.

  const MovieScreen({super.key, required this.movieId}); // Constructor con clave opcional y movieId requerido.

  @override
  MovieScreenState createState() => MovieScreenState(); // Crea el estado asociado con esta pantalla.
}

//* Estado asociado a MovieScreen.
class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // Inicializa la carga de la película y actores al iniciar la pantalla.
    ref.read(movieInfoProvider.notifier).loadMovie(movieId: widget.movieId);
    ref.read(actorsProvider.notifier).loadActors(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId]; // Obtiene la película actual del proveedor.

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2))); // Muestra un indicador de carga si la película no está disponible.
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // Utiliza una física de desplazamiento sin efecto de rebote.
        slivers: [
          //* Fondo de la pantalla (Imagen grande, gradientes...)
          _CustomSliverAppBar(movie: movie), // Barra de aplicación personalizada con información de la película.
          //* Detalles de la película (Imagen pequeña, descripción, actores...)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie), // Muestra los detalles de la película.
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

//* Widget personalizado que muestra una barra de aplicación con una imagen de fondo de la película.
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie; // Información de la película.
  const _CustomSliverAppBar({required this.movie}); // Constructor con película requerida.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla.
    //* Fondo de la pantalla
    return SliverAppBar(
      backgroundColor: Colors.black, // Color de fondo de la AppBar.
      expandedHeight: size.height * 0.7, // Altura expandida de la AppBar.
      foregroundColor: Colors.white, // Color del texto de la AppBar.
      actions: [
        IconButton(
            onPressed: () {
              ref.watch(isarRepositoryProvider).toggleFavorite(movie);
            },
            icon: const Icon(Icons.favorite_border))
        // icon: const Icon(Icons.favorite_rounded, color: Colors.red))
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Padding alrededor del título.
        background: Stack(
          children: [
            //* Contenido del fondo de la pantalla
            SizedBox.expand(
              //* Imagen del póster del fondo de la pantalla
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover, // Ajuste de la imagen para cubrir el fondo.
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox(); // Muestra un espacio en blanco mientras se carga la imagen.
                  return FadeIn(child: child); // Muestra la imagen con efecto de desvanecimiento.
                },
              ),
            ),
            //* Gradiente superior central
            _CustomGradient(
              beginAlign: Alignment.bottomCenter,
              endAlign: Alignment.topCenter,
              stops: const [0.8, 1.0],
              colors: const [Colors.transparent, Colors.black54],
            ),
            //* Gradiente inferior central
            _CustomGradient(
              beginAlign: Alignment.topCenter,
              endAlign: Alignment.bottomCenter,
              stops: const [0.8, 1.0],
              colors: const [Colors.transparent, Colors.black54],
            )
          ],
        ),
      ),
    );
  }
}

//* Widget que muestra los detalles de una película, incluyendo imagen, descripción y género.
class _MovieDetails extends StatelessWidget {
  final Movie movie; // Información de la película.
  const _MovieDetails({required this.movie}); // Constructor con película requerida.

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla.
    final textStyles = Theme.of(context).textTheme; // Obtiene los estilos de texto del tema.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8), // Padding alrededor de la fila.
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Imagen de la película.
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Redondea las esquinas de la imagen.
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3, // Ancho de la imagen basado en el tamaño de la pantalla.
                ),
              ),
              const SizedBox(width: 10), // Espaciado entre la imagen y la descripción.
              //* Descripción de la película.
              SizedBox(
                width: (size.width - 40) * 0.7, // Ancho del contenedor de descripción.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge), // Título de la película.
                    Text(movie.overview), // Descripción de la película.
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8), // Padding alrededor del contenedor de géneros.
          child: Wrap(
            children: [
              //* 'Chips' para cada género de la película.
              ...movie.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 10), // Margen entre los chips.
                  child: Chip(
                    label: Text(genre), // Etiqueta del chip con el nombre del género.
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Bordes redondeados.
                  ),
                ),
              ),
            ],
          ),
        ),
        //* Actores
        _ActorsMovie(movieId: movie.id.toString()), // Muestra los actores de la película.
        const SizedBox(height: 50) // Espaciado al final de la columna.
      ],
    );
  }
}

//* Widget que muestra una lista horizontal de actores que participaron en la película.
class _ActorsMovie extends ConsumerWidget {
  final String movieId; // ID de la película.
  const _ActorsMovie({required this.movieId}); // Constructor con ID de película requerido.

  @override
  Widget build(BuildContext context, ref) {
    final actorsMovie = ref.watch(actorsProvider); // Obtiene la lista de actores del proveedor.
    if (actorsMovie[movieId] == null) {
      // Muestra un indicador de carga si los actores aún no están disponibles.
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsMovie[movieId]!; // Lista de actores para la película.

    return SizedBox(
      height: 300, // Altura del contenedor de actores.
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Lista desplazable horizontalmente.
        itemCount: actors.length, // Número de actores en la lista.
        itemBuilder: (context, index) {
          final actor = actors[index]; // Actor actual en la lista.
          return Container(
            padding: const EdgeInsets.all(8), // Padding alrededor del contenedor del actor.
            width: 135, // Ancho del contenedor del actor.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  //* Imagen del actor
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Redondea las esquinas de la imagen del actor.
                    child: Image.network(
                      actor.profilePath,
                      height: 180, // Altura de la imagen del actor.
                      width: 135, // Ancho de la imagen del actor.
                      fit: BoxFit.cover, // Ajuste de la imagen para cubrir el contenedor.
                    ),
                  ),
                ),
                const SizedBox(height: 5), // Espaciado entre la imagen y el nombre del actor.
                //* Nombre del actor
                Text(
                  actor.name,
                  maxLines: 2, // Máximo de dos líneas para el nombre del actor.
                  style: const TextStyle(fontWeight: FontWeight.bold), // Estilo del texto del nombre.
                ),
                //* Personaje interpretado por el actor
                Text(
                  actor.character ?? '', // Personaje del actor o cadena vacía si es nulo.
                  maxLines: 2, // Máximo de dos líneas para el personaje.
                  style: const TextStyle(overflow: TextOverflow.ellipsis), // Estilo del texto del personaje con elipsis si es necesario.
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.beginAlign,
    required this.endAlign,
    required this.stops,
    required this.colors,
  })  : assert(stops.length == 2, 'La lista "stops" debe contener exactamente 2 elementos.'),
        assert(colors.length == 2, 'La lista "colors" debe contener exactamente 2 elementos.');

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: beginAlign, // Inicio del gradiente.
            end: endAlign, // Fin del gradiente.
            stops: stops, // Puntos de parada del gradiente.
            colors: colors, // Colores del gradiente.
          ),
        ),
      ),
    );
  }
}
