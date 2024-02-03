import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  /* mostramos movies */
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //todo
      if (widget.loadNextPage == null) {
        return;
      }
      /* 
    si la posicion actual mas 200 pixeles y si llega a superar la posicion maxima
    margen 200 px
mandamos a llamar la funcion
     */
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(
              subtitle: widget.subtitle,
              title: widget.title,
            ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final Movie movie = widget.movies[index];
              return FadeInRight(
                child: GestureDetector(
                  onTap: () => context.push('/home/0/movie/${movie.id}'),
                  child: _Slide(
                    movie: movie,
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* imagen */
          SizedBox(
            width: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          /* titulo */
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
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
              Text('${movie.voteAverage}',
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800)),
              SizedBox(
                width: 10,
              ),
              Text(HumanFormats.number(movie.popularity),
                  style: textStyle.bodySmall),
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              child: Text(subtitle!),
            )
        ],
      ),
    );
  }
}
