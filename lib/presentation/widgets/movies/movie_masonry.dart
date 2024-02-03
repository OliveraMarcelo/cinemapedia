import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() { 
          if (widget.loadNextPage == null) return; 
          if ((scrollController.position.pixels + 100)>= scrollController.position.maxScrollExtent) {
          widget.loadNextPage!();
          }
    });
    super.initState();
  }
  @override
  void dispose() {
    scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final movies = widget.movies;
    return MasonryGridView.count(
      controller: scrollController,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: movies.length,
       itemBuilder: (context, index) {
        final movie = movies[index];
        if (index == 1) {
        return Column(
          children: [SizedBox(
            height: 40,
          ),
          MoviePosterLink(movie : movie)
          ],
        );
        }
         return MoviePosterLink(movie : movie);
       },
       );
  }
}

