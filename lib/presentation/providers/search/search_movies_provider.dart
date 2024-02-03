import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositorProvider);
  
  return SearchedMoviesNotifier(
      ref: ref, searchMovies: movieRepository.searchMovies);/* pasamos ref */
});
/* 
wnecesito poder recibir la funcion para buscar las peliculas que esta en nuestra implementacion moviesrepositoryimpl
 */
typedef SearchedMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesCallback searchMovies;
  final Ref ref;/* para poder llamar providers dentro de otro providers */
  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
