import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movie_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:cinemapedia/presentation/widgets/actors/actors_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorInfoProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null)
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return _MovieDetails(movie: movie);
            },
          )),
        ],
      ),
    );
  }
}

class _MovieDetails extends ConsumerWidget {
  final Movie movie;
  const _MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, ref) {
    final List<Actor>? actors = ref.watch(actorInfoProvider)[movie.id];

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final dateMovieRelease = DateFormat('dd/MM/yyyy').format(movie.releaseDate);
    final languageOriginalMovie = movie.originalLanguage == 'en'
        ? 'Ingles'
        : movie.originalLanguage == 'es'
            ? 'Español'
            : movie.originalLanguage;
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        movie.posterPath,
                        width: size.width * 0.3,
                      ),
                    ),
                    Text('Promedio de votos'),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_outlined,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('${movie.voteAverage}',
                            style: textStyles.bodyMedium
                                ?.copyWith(color: Colors.yellow.shade800))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: (size.width - 60) * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.originalTitle,
                        style: textStyles.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(movie.overview),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Idioma original  : $languageOriginalMovie '),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Dia de lanzamiento  : ${dateMovieRelease} '),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Votos contados : ${movie.voteCount} '),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genreIds.map((gender) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Chip(
                        label: Text(gender),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  );
                })
              ],
            ),
          ),
          _ActorsByMovie(movieId: movie.id.toString()),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorInfoProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Nombre
                const SizedBox(
                  height: 5,
                ),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
/* 
un futureprovider retorna un future

debo recibir un true o un false si el estado esta en favorito
 */
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) async {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId) ;
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    return SliverAppBar(
      backgroundColor: Colors.black,
      actions: [
        IconButton(
            onPressed: ()async {
              /* await ref.read(localStorageRepositoryProvider).toggleFavorite(movie); */
              await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
              /* invalida el estado y deja el valor al estado inicial  */
            }, // icon:Icon( Icons.favorite_border)
            icon: isFavoriteFuture.when(
              data: (isFavorite) => !isFavorite ?Icon( Icons.favorite_border)  : Icon(Icons.favorite_rounded,color: Colors.red) ,
             error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),) /* */)
      ],
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
              colors: [Colors.transparent, Colors.black87],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
              stops: [0.0, 0.2],
            ),
             const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
              stops: [0.0, 0.2],
            ),
          ],
        ),
        centerTitle: true,
        title: Text(movie.title),
      ),
    );
  }
}

/* 
nuestros widgets no llaman implementaciones si no nuestros sidgets llaman providers
 */
class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double>? stops;
  final List<Color> colors;
  const _CustomGradient({
    super.key,
    required this.begin,
    required this.end,
    this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: begin, end: end, stops: stops, colors: colors))));
  }
}
