import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/* 
tengo que definirme una funcion para 
hacer el searchMovies como va lucir que propiedades se fdefine ? 
cualquiier funcion que cunmpla la firma 
 */

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovies;
  List<Movie> initialMovies;

  final StreamController<List<Movie>> debounceMovies =
      StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;
  /* 
  por que broadcast ? 
  asi tiene multiples listenes
   */

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  void clearStream() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    /* determino si el timer tiene un vcalor , si esta activo lo voy a limpiar  */
    /*  */
    /* tan pronto la persona escribe le aparece el loading*/
    isLoadingStream.add(true);
    print('query string cambio');

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      print('Buscando peliculas');
      /* if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      } */
      final movies = await searchMovies(query);
      initialMovies = movies;
      debounceMovies.add(movies);
      isLoadingStream.add(false);
    });
    /* 
    tenemos nuestra funcion que cada vez que 
    tiene un timer que se la pasa cancelando cada vez que la persona escribe
    y si deja de escribir por 500 milisegundos ahi hace lo que tiene el callback en nuestoro caso la peticion http
    
     */
  }

/* 
cambiamnos el future buiilder por un stream builder
entonces cada vez que m,i stream personalizado emita valores hay es donde voy a renderizar el contenido
 y ese stream va emitir valores hasta que la persona deje de escribir
 */

  @override
  String get searchFieldLabel => 'Buscar pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return FadeIn(
              child: SpinPerfect(
                  spins: 10,
                  infinite: true,
                  duration: const Duration(seconds: 20),
                  child: Icon(Icons.refresh_rounded)),
            );
          } else {
            return FadeIn(
              child: IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: Icon(Icons.clear)),
            );
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_outlined),
      onPressed: () {
        clearStream();
        close(context, null);
      },
    );
  }

/* 
por que no aparece nada cuando apreto enter?
por que el valor de este streambuilder y crea una un nuevo listener
y al principio no crea un nuevo valor .
lo solucionamos 
yop se que tengo que escuchar el estreeam y esta bien
el initialMovies = movies cuando tengo el valor
las initial movies siempre va tener data luego
asi que la initialData sera igual a las initialMovies
 */
  @override
  Widget buildResults(BuildContext context) {
    return BuildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return BuildResultsAndSuggestions();
  }

  StreamBuilder<List<Movie>> BuildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        //if (movies.isEmpty) return Text('No hay peliculas');
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    super.key,
    required this.movie,
    required this.onMovieSelected,
  });

  final Movie movie;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onMovieSelected(context, movie);
        },
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: (size.width * 0.8 - 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(
                          movie.overview,
                        ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(HumanFormats.number(movie.voteAverage, 2),
                          style: textStyles.bodyMedium
                              ?.copyWith(color: Colors.yellow.shade800)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
