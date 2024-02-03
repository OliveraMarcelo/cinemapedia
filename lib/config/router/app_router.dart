import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';

/* 
wconfiguracion ded las rutas para conservar el estado 
go router con estado
 */

final appRouter = GoRouter(
   initialLocation: '/home/0',
  routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
         final pageIndex= state.pathParameters['page'] ?? '0';
         return  HomeScreen( pageIndex: int.parse(pageIndex));
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        )
      ],
      ),
      GoRoute(path: '/', redirect: (context, state) =>'/home/0' ,)
]);
