import 'package:cinemapedia/infraestructure/datasources/actordb_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositorProvider = Provider((ref) {
  return ActorRepositoryImpl(  ActorMovieDbDatasource());
});
