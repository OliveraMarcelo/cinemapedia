import 'package:cinemapedia/domain/entities/movie.dart';

/* 
vamos a ocupar el togglefavorite recibimos toda la pelicula 
me va madnar la pelicula y tenewmos la info necesaria para cambiarla 
isMovieFavorite es para verificar si la pelicula esta en mis favoritos

 */
abstract class LocalStorageDatasource{
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});

}