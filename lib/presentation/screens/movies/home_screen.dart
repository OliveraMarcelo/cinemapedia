import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/views/favorite_view.dart';
import 'package:cinemapedia/presentation/views/home_view.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});


  final viewRouter = const<Widget>[
    HomeView(),
    SizedBox(),
    FavoriteView()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index : pageIndex,
        children: viewRouter,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex : pageIndex),
    );
  }
}

