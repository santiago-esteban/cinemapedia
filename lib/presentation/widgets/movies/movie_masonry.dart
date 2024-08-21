//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//* Muestra películas en una vista masonry
class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  //* Inicializar las películas y la función de carga de la próxima página
  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //* Añadir un listener para cargar más películas al llegar al final del scroll
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!(); //* Llama al callback para cargar más películas
      }
    });
  }

  @override
  void dispose() {
    //* Limpieza del controlador de desplazamiento
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //* Construcción del layout del masonry para mostrar películas
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            //* Caso especial para el segundo ítem para mostrar un diseño diferente
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(movie: widget.movies[index]), //* Póster de la película del medio
              ],
            );
          }
          return MoviePosterLink(movie: widget.movies[index]); //* Pósters de las películas laterales
        },
      ),
    );
  }
}
