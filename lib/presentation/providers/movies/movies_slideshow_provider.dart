/* 
nowplaying 
este provider cuenta de 0 a 6 es solo para leer
este provider se encarga de solo mostrar 6 peliculas en el swiper
 */

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0,6);
});