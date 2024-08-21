//* Importaciones de paquetes necesarios.
import 'package:cinemapedia/config/config.dart';
import 'package:flutter/material.dart';

//* Mostrar la calificación de una película
class MovieRating extends StatelessWidget {
  final double voteAverage;

  const MovieRating({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    //* Widget para visualizar la calificación con un ícono y un texto
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          //* Ícono de estrella
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
          const SizedBox(width: 3),
          Text(
            //* Texto que muestra el promedio de votos formateado
            Formats.number(voteAverage, 1),
            style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),
          ),
        ],
      ),
    );
  }
}
