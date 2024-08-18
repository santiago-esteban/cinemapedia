import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Un widget que muestra un carrusel de películas en un `Swiper` con efectos de transición.
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
      height: 210, // Altura fija del carrusel
      width: double.infinity, // Ancho ocupa todo el espacio disponible
      child: Swiper(
        viewportFraction: 0.8, // Porcentaje del tamaño del viewport visible
        scale: 0.9, // Escala de los elementos para dar un efecto de profundidad
        autoplay: true, // Reproduce automáticamente el carrusel
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0), // Margen superior para la paginación
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary, // Color del punto activo
            color: colors.secondary, // Color del punto inactivo
          ),
        ),
        itemCount: movies.length, // Número de elementos en el carrusel
        //* Elementos del carrusel
        itemBuilder: (context, index) => _SlideCustomWidget(movie: movies[index]), // Construye cada elemento del carrusel
      ),
    );
  }
}

//* Un widget que representa una película en el carrusel.
class _SlideCustomWidget extends StatelessWidget {
  final Movie movie;

  const _SlideCustomWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    //* Decoración para los elementos.
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20), // Bordes redondeados
      boxShadow: const [
        BoxShadow(
          color: Colors.black45, // Color de la sombra
          blurRadius: 10, // Radio de desenfoque de la sombra
          offset: Offset(0, 10), // Desplazamiento de la sombra
        ),
      ],
    );

    //* Imagen de la película.
    return Padding(
      padding: const EdgeInsets.only(bottom: 30), // Espacio en la parte inferior del elemento
      child: DecoratedBox(
        decoration: decoration, // Aplicar la decoración al elemento
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados en la imagen
          //* Imagen
          child: GestureDetector(
            onTap: () => context.push('/home/0/movie/${movie.id}'),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              image: NetworkImage(movie.backdropPath),
            ),
          ),
        ),
      ),
    );
  }
}
