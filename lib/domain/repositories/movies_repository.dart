import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int  page = 1});

  Future<List<Movie>> getPopulars({int  page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future <Movie> getMovieById(String id);

  Future <List<Movie>> searchMovies(String query);

}
/* 
los repositorios llaman el datasource
nuestro origenes de datos es el datasource y
los repositorios son quienes llaman al datasource .
reposiotrio me permite cambiar el datasource

 */