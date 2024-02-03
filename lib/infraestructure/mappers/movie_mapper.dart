/* 
cual es el objetivo de mi mapper ?
va tener como mision leer diferentes modelos yy crear mio entidad

cual es el objetivo de este mapper ?

la idea es que nosotros podamos crear una pelicula
 basado en algun tipo de objeto que vamos a recibir

 */
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_moviedb.dart';

import '../../domain/entities/movie.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult!,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      genreIds: moviedb.genreIds!.map((e) => e.toString()).toList(),
      id: moviedb.id!,
      originalLanguage: moviedb.originalLanguage!,
      originalTitle: moviedb.originalTitle!,
      overview: moviedb.overview!,
      popularity: moviedb.popularity!,
      posterPath: (moviedb.posterPath != null)
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
          : 'https://cup-us.imgix.net/covers/9780860085423.jpg?w=350',
      releaseDate: moviedb.releaseDate!= null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title!,
      video: moviedb.video!,
      voteAverage: moviedb.voteAverage!,
      voteCount: moviedb.voteCount!
      );

    static Movie movieDetailsToEntity(MovieDetails moviedb) =>Movie(
        adult: moviedb.adult!,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
      genreIds: moviedb.genres!.map((e) => e.name!).toList(),
      id: moviedb.id!,
      originalLanguage: moviedb.originalLanguage!,
      originalTitle: moviedb.originalTitle!,
      overview: moviedb.overview!,
      popularity: moviedb.popularity!,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
          : 'no-poster',
      releaseDate: moviedb.releaseDate!,
      title: moviedb.title!,
      video: moviedb.video!,
      voteAverage: moviedb.voteAverage!,
      voteCount: moviedb.voteCount!
    );

}
/* 
que pasaria si al dia de ma;ana overview es sinopsis solo aca cambias moviedb.overview a moviedb.sinopsis y listo
asi se ahorra en cambiar todo el codigo
 */