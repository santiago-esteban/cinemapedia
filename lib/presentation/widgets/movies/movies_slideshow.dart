import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

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
          child: Image.network(
            movie.backdropPath, // Ruta de la imagen de fondo de la película
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el área
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                // Muestra un fondo gris claro mientras se carga la imagen
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                );
              }
              //* Navegación a la pantalla individual de la película
              return GestureDetector(
                onTap: () => context.push('/home/0/movie/${movie.id}'), // Navega a la pantalla de detalles de la película cuando se toca
                child: FadeIn(child: child), // Se muestra el widget en FadeIn para un efecto de desvanecimiento
              );
            },
          ),
        ),
      ),
    );
  }
}
