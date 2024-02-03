/* 
basado en los principios solid 
 */
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
lo que hara que cuadno yo necesito saber las ultimas peliculas en el cine
puedo consultar este provider para esa informacion
 

por que esz notifier?  por que me va permitir contorlarlo aca  nowPlayingMoviesProvider
 */

/* 
el StateNotifierProvider ees un proveedor de un estado que notifica su cambio 

 */
/* 
nowPlayingMoviesProvider lo que va regresar es una instancia de mi MoviesNotifier
el statenotifier(la clase que sirve para notificar) y el listado de movie(el state)
 */
/* como podemos traernos getnowplaying 
definiendo el caso de uso
typedef para especificar le tipo de funcion que recibiremos
*/

typedef MovieCallback = Future<List<Movie>> Function({int page});

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref
      .watch(movieRepositorProvider)
      .getNowPlaying; // nos pasamos la referencia de la funcion
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref
      .watch(movieRepositorProvider)
      .getPopulars; // nos pasamos la referencia de la funcion
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref
      .watch(movieRepositorProvider)
      .getTopRated; // nos pasamos la referencia de la funcion
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});
final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref
      .watch(movieRepositorProvider)
      .getUpcoming; // nos pasamos la referencia de la funcion
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});
/* 
el stateNotifier solo es una clase que sirve para manejar este estado soea List<Movie>
 */
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);
/* el objetivo es que proporcione este listado de movies */
  Future<void> loadNextPage() async {
    if (isLoading) return; // se bloque para que no este
    print('paso');
    isLoading = true;
    currentPage++; // cuando yo llame a la siguiente pagina sera la pagina 1
    final List<Movie> movies =
        await fetchMoreMovies(page: currentPage); // todo getNowPlaying
    state = [
      ...state,
      ...movies
    ]; // ocupo al state para agregar un nuevo listado de movies
    /* cuando el estado cambia notifica */
    await Future.delayed(Duration(milliseconds: 300));
    isLoading = false;
  }
} /* este moviesnotifier es el controlador de este estado */
