import 'dart:async';

import 'package:cinemapedia/config/router/app_router.dart'; // Importa la configuración del enrutador de la aplicación.
import 'package:cinemapedia/config/theme/app_theme.dart'; // Importa la configuración del tema de la aplicación.
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importa el paquete para manejar variables de entorno.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Carga las variables de entorno desde el archivo .env.
  runApp(const ProviderScope(child: MyApp())); // Ejecuta la aplicación y envuelve el widget principal en `ProviderScope` para que Riverpod pueda manejar el estado.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // Configura el enrutador de la aplicación con la configuración definida en `appRouter`.
      debugShowCheckedModeBanner: false, // Desactiva el banner de depuración que aparece en el modo de depuración.
      theme: AppTheme().getTheme(), // Establece el tema de la aplicación utilizando la configuración proporcionada por `AppTheme`.
    );
  }
}
