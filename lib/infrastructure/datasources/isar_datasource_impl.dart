//* Importa las librerías y clases necesarias para la implementación del datasource de Isar Database.
import 'package:cinemapedia/domain/domain.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//* Implementación concreta del datasource para manejar la base de datos Isar.
class IsarDatasourceImpl extends IsarDatasource {
  late Future<Isar> db;

  IsarDatasourceImpl() {
    db = openDB();
  }

  //* Abre la base de datos Isar.
  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  //* Verifica si una película es favorita.
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavoriteMovie != null;
  }

  //* Carga una lista de películas con límite y desplazamiento opcionales.
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  //* Alterna el estado de favorito de una película.
  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie != null) {
      //* Borra la película de favoritos.
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }
    //* Añade la película a favoritos.
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
