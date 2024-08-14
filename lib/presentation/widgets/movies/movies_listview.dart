import 'package:flutter/material.dart'; // Importa widgets básicos de Flutter.
import 'package:cinemapedia/domain/entities/movie.dart'; // Importa la entidad Movie.
import 'package:cinemapedia/config/helpers/human_formats.dart'; // Importa helper para formatos de números.
import 'package:go_router/go_router.dart'; // Importa go_router para la navegación.
import 'package:animate_do/animate_do.dart'; // Importa animate_do para animaciones.

//* Widget que muestra una lista horizontal de películas con título y subtítulo opcionales.
class MoviesListview extends StatefulWidget {
  final List<Movie> movies; // Lista de películas a mostrar.
  final String? title; // Título opcional.
  final String? subTitle; // Subtítulo opcional.
  final VoidCallback? loadNextPage; // Callback opcional para cargar más películas al llegar al final de la lista.

  const MoviesListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MoviesListview> createState() => _MoviesListviewState(); // Crea el estado asociado con este widget.
}

class _MoviesListviewState extends State<MoviesListview> {
  final scrollController = ScrollController(); // Controlador para el desplazamiento horizontal de la lista.

  @override
  void initState() {
    super.initState();
    //* Añade un listener para detectar cuando el usuario llega al final de la lista y cargar más datos si es necesario.
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!(); // Llama al callback para cargar más datos.
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // Libera recursos del controlador al destruir el widget.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350, // Altura del contenedor de la lista.
      child: Column(
        children: [
          //* Encabezado del list view.
          if (widget.title != null || widget.subTitle != null) _TitleCustomWidget(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController, // Asigna el controlador de desplazamiento a la lista.
              itemCount: widget.movies.length, // Número de elementos en la lista.
              scrollDirection: Axis.horizontal, // Desplazamiento horizontal.
              physics: const BouncingScrollPhysics(), // Física de desplazamiento con rebote.
              itemBuilder: (context, index) {
                //* Contenido del list view (Imagen, título de la película y valoraciones).
                return FadeInRight(child: _SlideCustomWidget(movie: widget.movies[index])); // Anima cada elemento con FadeInRight.
              },
            ),
          ),
        ],
      ),
    );
  }
}

//* Widget que muestra el encabezado para el list view de la lista de películas.
class _TitleCustomWidget extends StatelessWidget {
  final String? title; // Título opcional.
  final String? subTitle; // Subtítulo opcional.

  const _TitleCustomWidget({this.title, this.subTitle}); // Constructor con título y subtítulo opcionales.

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge; // Estilo del título del tema.

    return Container(
      padding: const EdgeInsets.only(top: 10), // Padding superior para el título.
      margin: const EdgeInsets.symmetric(horizontal: 10), // Margen horizontal alrededor del contenedor del título.
      child: Row(
        children: [
          //* Título (En cines, próximamente...)
          if (title != null) Text(title!, style: titleStyle), // Muestra el título si está disponible.
          const Spacer(), // Espacio flexible para alinear el subtítulo a la derecha.
          //* Subtítulo (Sábado 10, este mes...)
          if (subTitle != null)
            FilledButton.tonal(
              onPressed: () {}, // Acción cuando se toca el subtítulo.
              style: const ButtonStyle(visualDensity: VisualDensity.compact), // Estilo compacto para el botón.
              child: Text(subTitle!), // Muestra el subtítulo en el botón.
            ),
        ],
      ),
    );
  }
}

//* Widget que representa un elemento de la lista de películas, incluyendo imagen, título y calificación.
class _SlideCustomWidget extends StatelessWidget {
  final Movie movie; // Película para mostrar.

  const _SlideCustomWidget({required this.movie}); // Constructor con película requerida.

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme; // Obtiene los estilos de texto del tema.

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9), // Margen horizontal alrededor de cada elemento.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen de la película.
          SizedBox(
            width: 150, // Ancho de la imagen.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Redondea las esquinas de la imagen.
              child: Image.network(
                movie.posterPath, // Ruta de la imagen de la película.
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor.
                width: 150, // Ancho de la imagen.
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2)); // Muestra un indicador de carga mientras la imagen se descarga.
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'), // Navega a la pantalla de detalles de la película al tocar la imagen.
                    child: FadeIn(child: child), // Aplica una animación de desvanecimiento a la imagen.
                  );
                },
              ),
            ),
          ),

          //* Título de la película.
          SizedBox(
            width: 150, // Ancho del contenedor del título.
            child: Text(
              movie.title, // Título de la película.
              maxLines: 2, // Máximo de dos líneas para el título.
              style: textStyles.titleSmall, // Estilo del texto del título.
            ),
          ),

          //* Calificación y popularidad de la película.
          SizedBox(
            width: 150, // Ancho del contenedor para la calificación.
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800), // Icono de estrella para la calificación.
                const SizedBox(width: 3), // Espaciado entre el icono y el texto de la calificación.
                Text(HumanFormats.number(movie.voteAverage, 1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)), // Calificación de la película.
                const Spacer(), // Espacio flexible para separar la calificación de la popularidad.
                Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall) // Popularidad de la película.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
