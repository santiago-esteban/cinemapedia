import 'package:flutter/material.dart';

//* Un widget que muestra una pantalla de carga completa con un indicador de progreso y mensajes de carga que cambian periódicamente.
class CustomScreenLoader extends StatelessWidget {
  const CustomScreenLoader({super.key});

  //* Genera un `Stream` de mensajes de carga que cambian cada cierto tiempo.
  Stream<String> getLoadMessages() {
    // Lista de mensajes de carga que se mostrarán en la pantalla.
    final messages = <String>[
      'Cargando películas...',
      'Comprando palomitas...',
      'Bebiendo refresco...',
      'Llamando a mi novia...',
      'Modo avión activado...',
      'Listo para disfrutar...',
    ];

    //* Crea un `Stream` que emite un mensaje diferente cada 1200 milisegundos.
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step]; // Devuelve el mensaje correspondiente al paso actual.
    }).take(messages.length); // Limita el `Stream` a la longitud de la lista de mensajes.
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10), // Espacio superior entre el indicador de progreso y el texto.
          const CircularProgressIndicator(strokeWidth: 2), // Indicador de progreso circular.
          const SizedBox(height: 10), // Espacio inferior entre el indicador de progreso y el texto.
          StreamBuilder<String>(
            stream: getLoadMessages(), // Se escucha el `Stream` generado.
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...'); // Mensaje predeterminado mientras se carga el primer dato.
              return Text(snapshot.data!); // Muestra el mensaje actual del `Stream`.
            },
          ),
        ],
      ),
    );
  }
}
