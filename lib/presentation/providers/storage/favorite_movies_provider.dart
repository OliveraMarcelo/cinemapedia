import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/* 
 */
final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int,Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int,Movie>>{
  int page = 0; // pagina actual 0
    /*  pedimos el lclrepository 
    otra manera de llamar a las funciones de   LocalStorageRepository
    */
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});
  /* ncesito una forma para cargar las movies */
  Future<List<Movie>> loadNextPage()async{
    final movies =  await localStorageRepository.loadMovies(offset: page* 10, limit: 20 );
    page++;
    /* actualizar elk state 
    lista de pelis
    */
    /* el tema si lo hacemos de la primera manera tendriamos 20 actualizaciones del state y no queremos eso */
    /* nos creamos tempomoviesmap */
    final tempMoviesMap = <int,Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    /* state = {...state,movie.id : movie};  */ 
    }
    /* aca solo actualizamos una variable y luego ahi ya actualizamos el estado (para no ahcer las actualizaciones en el for) */
    state = {...state, ...tempMoviesMap};  
    return movies;
  }

  Future<void> toggleFavorite(Movie movie)async{
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id]!= null;/* la pelicula existe o no */
    if (isMovieInFavorites) {
    state.remove(movie.id);
    state = {...state};
    }
    else{
      state = {...state, movie.id : movie};
    }
  }

}