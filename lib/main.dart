//* Importaciones de paquetes necesarios.
import 'dart:async';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Función principal que inicializa la aplicación
Future<void> main() async {
  await dotenv.load(fileName: ".env"); //* Carga las variables de entorno
  runApp(const ProviderScope(child: MyApp())); //* Ejecuta la aplicación dentro de un `ProviderScope` para usar Riverpod
}

//* Widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, //* Configura las rutas de la aplicación
      theme: AppTheme().getTheme(), //* Aplica el tema personalizado de la aplicación
    );
  }
}
