import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'home_screen';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    /* 
    aca manda a llamar la primera pagina 
     */
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

/* 
lo que tendriamos que hacer es controlar cuantas peliculas quiero mandar en MovieSlideShow */
  @override
  Widget build(BuildContext context) {
    /* y vigilamos la data y la renderizamos */
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    final moviesPopulars = ref.watch(popularMoviesProvider);
    final moviesUpcoming = ref.watch(upcomingMoviesProvider);
    final moviesTopRated = ref.watch(topRatedMoviesProvider);
    final loadingMovies = ref.watch(initialLoadingProvider);
    if (loadingMovies) return const FullScreenLoader();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                MovieSlideShow(movies: moviesSlideShow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  subtitle: 'Lunes',
                  title: 'En cines',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: moviesUpcoming,
                  subtitle: 'Este mes',
                  title: 'Proximamente',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: moviesPopulars,
                  //subtitle: '',
                  title: 'Populares',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: moviesTopRated,
                  subtitle: 'De todos los tiempos',
                  title: 'Mejor calificadas',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
               const SizedBox(
                  height: 50,
                )
              ],
            );
          },
        ))
      ],
    );
  }
}
