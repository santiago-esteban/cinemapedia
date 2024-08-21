//* Importaciones de paquetes necesarios.
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Clase widget que muestra actores por película
class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    //* Observar cambios en el proveedor de actores por película
    final actorsByMovie = ref.watch(actorsMovieProvider);

    //* Widget para cargar actores si aún no están disponibles
    if (actorsByMovie[movieId] == null) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 50),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    final actors = actorsByMovie[movieId]!;

    //* Contenedor con lista desplazable horizontal de actores
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Animación de gif de carga
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                      image: NetworkImage(actor.profilePath),
                    ),
                  ),
                ),

                //* Espaciador entre imagen y texto
                const SizedBox(
                  height: 5,
                ),

                //* Texto con el nombre del actor
                Text(actor.name, maxLines: 2),
                //* Texto con el personaje del actor
                Text(actor.character ?? '', maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
              ],
            ),
          );
        },
      ),
    );
  }
}
