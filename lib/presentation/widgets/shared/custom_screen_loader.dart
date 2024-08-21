//* Importaciones de paquetes necesarios.
import 'package:flutter/material.dart';

//* Muestra una pantalla de carga con un indicador de progreso y mensajes que cambian periódicamente
class CustomScreenLoader extends StatelessWidget {
  const CustomScreenLoader({super.key});

  //* Genera un `Stream` de mensajes de carga que cambian
  Stream<String> getLoadMessages() {
    final messages = <String>[
      'Cargando películas...',
      'Comprando palomitas...',
      'Bebiendo refresco...',
      'Llamando a mi novia...',
      'Modo avión activado...',
      'Listo para disfrutar...',
    ];

    //* Emite un mensaje diferente cada 1200 milisegundos
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          //* Muestra los mensajes de carga usando un `StreamBuilder`
          StreamBuilder<String>(
            stream: getLoadMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
