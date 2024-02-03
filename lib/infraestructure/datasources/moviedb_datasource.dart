import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_db_response.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';

//obtenemos peliculas en cines
class MoviedbDatasource extends MovieDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results!
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    //necesito mi listado de movies
    // yo quiero usar mi entidad Movie para poder laburar con esos datos
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopulars({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    //necesito mi listado de movies
    // yo quiero usar mi entidad Movie para poder laburar con esos datos
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get(
      '/movie/${id}',
    );
    if (response.statusCode != 200)
      throw Exception('Movie with id : $id  not found');
    final movieDetails = MovieDetails.fromJson(response.data);

    /* 
    debemos hacer un Mapper que nos permita renderizar esa movie
     */
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonToMovies(response.data);
  }
  /* 
  en resumen 
  hicimos la parte datasource 
  definimos getMovieById que su caso de uso es obtener una pelicula por id 
  en la parter de respoitorio tambien obtenemos una forma de exponer ese getmoviebyid para que lo uso el datasource
  despues lo implementamos en moviedb_datasoruce en la aprte de la infractucture
   */
}
