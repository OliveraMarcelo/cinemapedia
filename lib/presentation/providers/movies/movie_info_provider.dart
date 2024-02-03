import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
cmo queremos que funcione ? 
nuestro state 
yo lo que voy a crear es un mapa donde voya a tener el id de la pelicula donde voy a tener el id de la pelicula
y apunte a una instancia de Movie
{
  '505642 : Movie()
}

 */

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String,Movie>>((ref) {
  final getMovie = ref.watch(movieRepositorProvider).getMovieById;
  return MovieMapNotifier(getMovie: getMovie);
});

typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});
/* inicilaizamos con un mapa vacio */
/* 
esto nos va servir para llamar la implementacion ded la funcion que trae la pelicula 
esto lo haremos generico para traer la implementacion de cualquier pelicula
 */
  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    /* si nuestro estado ya tiene pelicula de este id que no regrese nada ya que  la tengo cargada*/
    print('realizando peticion');
    final movie = await getMovie(movieId);
    state = {...state , movieId : movie};
  }
}
