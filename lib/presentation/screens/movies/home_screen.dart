//* Importa las librerías y clases necesarias.
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';

//* Pantalla principal que muestra la interfaz de inicio de la aplicación.
class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* Este Mixin es necesario para mantener el estado en el PageView.
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //* Lista de vistas que se pueden mostrar en la pantalla de inicio.
  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return Scaffold(
      //* Cuerpo de la pantalla, que muestra la vista correspondiente al índice actual.
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      //* Barra de navegación personalizada en la parte inferior de la pantalla.
      bottomNavigationBar: CustomNavigationbar(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
