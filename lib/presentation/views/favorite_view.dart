import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNextPage();
    /* para tener acceso al notifier tenemos acceso al objeto y a los metodos, en nuestro notifier loadNextPage   */
  }
  void loadNextPage ()async {
    /* si esta cargando o es la ultima pagina entonces se sale de la funcion */
    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {/* si ya no hay mas peliculas que recibe movies entonces is last page es la ultima pagina */
    isLastPage = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesProvider).values.toList();/* asi obtenemos los valores de cada movie como un arreglo  */
   print(movies);
  final colors = Theme.of(context).colorScheme;
   if (movies.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 60, color: colors.primary,),
          Text('Oh chabon', style: TextStyle(fontSize: 30, color: colors.primary),),
          Text('No hay pelis favoritas', style: TextStyle(fontSize: 20,color: colors.secondary),)
        ],
      ),
    );
   }
    return Scaffold(
      body:  MovieMasonry(
        loadNextPage: loadNextPage,
        movies: movies)
    );
  }
}