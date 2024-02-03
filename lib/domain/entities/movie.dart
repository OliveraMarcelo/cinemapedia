// la respuesta que a mi me debe llegar como entidad que yo quiero
//nuestro modelo propio, quiero pasar la respuestqa en base a mi entidad , no necesariamente con la entidad de themoviedb

import 'package:isar/isar.dart';
/* isar id es un id unico para la bd */
part 'movie.g.dart';/* esto es un archivo que se va generar de manera automatica ,
 nos crea nuestro esquema para poder hacer muchas funcionalidades como una base dee datos
*/
@collection
class Movie {
  Id isarId = Isar.autoIncrement;
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}