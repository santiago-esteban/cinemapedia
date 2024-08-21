//* Importaciones necesarias para el funcionamiento del widget y la lógica de negocio
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//* Proveedor que obtiene la lista de videos de YouTube para una película específica
final FutureProviderFamily<List<Video>, int> movieVideoProvider = FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);
});

//* Widget principal que muestra los videos de una película
class MovieVideo extends ConsumerWidget {
  final int movieId;
  const MovieVideo({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* Observa el proveedor de videos para cargar los datos
    final moviesFromVideo = ref.watch(movieVideoProvider(movieId));
    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, __) => const Center(child: Text('No se pudo cargar películas similares')),
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

//* Widget que muestra la lista de videos
class _VideosList extends StatelessWidget {
  final List<Video> videos;
  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    //* Si no hay videos que mostrar
    if (videos.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        //* Muestra solo el primer video de la lista
        _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: videos.first.name)
        //* Si se desea mostrar todos los videos
        // ...videos.map((video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)).toList()
      ],
    );
  }
}

//* Widget que controla la reproducción del video de YouTube
class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;
  const _YouTubeVideoPlayer({required this.youtubeId, required this.name});

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

//* Estado del widget que maneja el controlador de YouTube
class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    //* Inicializa el controlador de YouTube con las configuraciones necesarias
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    //* Libera el controlador cuando ya no se necesita
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Muestra el nombre del video
          Text(widget.name),
          //* Reproductor de YouTube
          YoutubePlayer(controller: _controller)
        ],
      ),
    );
  }
}
