//* Importaciones necesarias para el funcionamiento del widget y animaciones
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Muestra una lista horizontal de películas con título y subtítulo opcionales
class MoviesListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  //* Crea el estado asociado con este widget
  @override
  State<MoviesListview> createState() => _MoviesListviewState();
}

class _MoviesListviewState extends State<MoviesListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //* Añade un listener para detectar cuando el usuario llega al final de la lista y cargar más datos si es necesario
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!(); //* Llama al callback para cargar más datos
      }
    });
  }

  //* Libera recursos del controlador al destruir el widget
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          //* Encabezado del list view
          if (widget.title != null || widget.subTitle != null) _TitleCustomWidget(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                //* Contenido del list view: imagen, título de la película y valoraciones
                return FadeInRight(child: _SlideCustomWidget(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

//* Widget que muestra el encabezado para el list view de la lista de películas
class _TitleCustomWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _TitleCustomWidget({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: [
          //* Título (En cines, próximamente...)
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          //* Subtítulo (Sábado 10, este mes...)
          if (subTitle != null) FilledButton.tonal(onPressed: () {}, style: const ButtonStyle(visualDensity: VisualDensity.compact), child: Text(subTitle!)),
        ],
      ),
    );
  }
}

//* Widget que representa un elemento de la lista de películas, incluyendo imagen, título y calificación
class _SlideCustomWidget extends StatelessWidget {
  final Movie movie;

  const _SlideCustomWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen de la película
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'),
                child: FadeInImage(
                  height: 220,
                  fit: BoxFit.cover,
                  //* Gif de carga
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  //* Imagen de la película
                  image: NetworkImage(movie.posterPath),
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Título de la película
          SizedBox(width: 150, child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall)),

          //* Calificación y popularidad de la película
          MovieRating(voteAverage: movie.voteAverage),
        ],
      ),
    );
  }
}
