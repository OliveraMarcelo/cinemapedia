import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActorHorizontalListview extends StatefulWidget {
  /* mostramos movies */
  final List<Actor> actors;

  const ActorHorizontalListview({
    super.key,
    required this.actors,
  });

  @override
  State<ActorHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<ActorHorizontalListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ListView.builder(
        itemCount: widget.actors.length,
        scrollDirection: Axis.horizontal,
        /* controller: scrollController, */
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final Actor actor = widget.actors[index];
          return FadeInRight(
            child: _Slide(
              actor: actor,
            ),
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Actor actor;
  const _Slide({super.key, required this.actor});

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
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                actor.profilePath,
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
              actor.name ?? '',
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
           SizedBox(
            width: 150,
            child: Text(
              actor.character ?? '',
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
