//* Importaciones necesarias para el funcionamiento del widget y la lógica de negocio
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Widget que muestra un carrusel de películas
class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(activeColor: colors.primary, color: colors.secondary),
        ),
        //* Número de películas en el carrusel
        itemCount: movies.length,
        //* Construcción de cada diapositiva
        itemBuilder: (context, index) => _SlideCustomWidget(movie: movies[index]),
      ),
    );
  }
}

//* Widget que representa una película en el carrusel
class _SlideCustomWidget extends StatelessWidget {
  final Movie movie;

  const _SlideCustomWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    //* Diseño general de la diapositiva
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => context.push('/home/0/movie/${movie.id}'),
            child: FadeInImage(
              fit: BoxFit.cover,
              //* Imagen de carga mientras se obtiene la imagen real
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              //* Imagen de la película
              image: NetworkImage(movie.backdropPath),
            ),
          ),
        ),
      ),
    );
  }
}
