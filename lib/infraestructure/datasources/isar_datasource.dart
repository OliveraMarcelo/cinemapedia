import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/* 
para hacer queries utilizamos el filter
isar.esquema.filter
isar.movie.filter
.esquemaslessthan(40) (esquema menor que 40) siar crea metodos con nuestros esquemas

 */
/* 
primero empezamos a tener la referencia de la bd
 */
/* 
si no hay instancia entonces se abre la bd con un esquema , importamos el movieesquema  y esta listo.
inspector en true te va poder permitir tener un servicio para analizar la bd 
en el caso que ya tengamos esa instancia
se regresa la misma instancia
 */
/* 
para 
 */
class IsarDatasource extends LocalStorageDatasource{
  late Future<Isar> db;/* tenemos que esperar la conexion de la bd */
IsarDatasource(){
  db = openDB();
}
Future<Isar> openDB()async{
      final dir = await getApplicationDocumentsDirectory();

  if(Isar.instanceNames.isEmpty){
    return await Isar.open([MovieSchema], directory: dir.path,inspector: true);
  }
      return Future.value(Isar.getInstance());

}
/* 
aca quiero preguntar si en la bases de datos una pelicula por ese id existe 
si yo quiero saber que una pleicula esta en favoritos
como sabemos que una pelicula es favorita
puede ser q el id este en favorito o no
 */
  @override
  Future<bool> isMovieFavorite(int movieId) async{
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst(); 
    /* por que idequal por que asi se llama el id y solo quiero encontrar el primero */  
    return isFavoriteMovie!=null;
    }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0})async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
/* necesito saber si la pelicula esta en favorito o no */
/* en este punto del if primeramente ya esta insertado entonces ya tiene el isarid */
  @override
  Future<void> toggleFavorite(Movie movie)async {
    final isar = await db;
    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie!=null) {
          isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));

      // borrar
    return;
    }
    // insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

}