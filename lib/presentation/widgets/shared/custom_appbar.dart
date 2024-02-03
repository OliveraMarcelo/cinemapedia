import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        child: Row(children: [
          Icon(Icons.movie_outlined, color: colors.primary),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Cinemapedia',
            style: titleStyle,
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                final movieRepository = ref.read(movieRepositorProvider);
                final queryProvider = ref.read(searchQueryProvider);
                final searchedMovies = ref.read(searchMoviesProvider);
                showSearch<Movie?>(
                    query: queryProvider,
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMovies: ref
                          .read(searchMoviesProvider.notifier)
                          .searchMoviesByQuery,
                      initialMovies: searchedMovies,
                    )).then((movie) {
                  if (movie == null) return;
                  context.push('/home/0/movie/${movie.id}');
                });
              },
              icon: Icon(Icons.search))
        ]),
      ),
    ));
  }
}
