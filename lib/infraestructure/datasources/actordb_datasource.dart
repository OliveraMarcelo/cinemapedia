import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));
  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final actorDbResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = actorDbResponse!.cast!
        .map((actordb) => ActorMapper.CastToEntity(actordb))
        .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200)
      throw Exception('Actor with id : $movieId  not found');

    /* 
    debemos hacer un Mapper que nos permita renderizar esa movie
     */
    return _jsonToActors(response.data);
  }
}
