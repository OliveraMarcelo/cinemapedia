import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopulars({int page = 1});
  
  Future<List<Movie>> getUpcoming({int page = 1});
  
  Future<List<Movie>> getTopRated({int page = 1});

  Future <Movie> getMovieById(String id);

  Future <List<Movie>> searchMovies(String query);

}

/* 
aca defino  que metodos traigo para mostrar mi data

quiero que me traiga la pelicula actual de la carteleria y en que pagina se vera
y el tipo de dato

*/