import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorInfoProvider =
    StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>((ref) {
  final getActor = ref.watch(actorRepositorProvider).getActorsByMovie;
  return ActorMapNotifier(getActor: getActor);
});

typedef GetActorCallback = Future<List<Actor>> Function(String actorId);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorCallback getActor;
  ActorMapNotifier({required this.getActor}) : super({});

  Future<void> loadActors(String actorId) async {
    if (state[actorId] != null) return;
    print('realizando peticion');
    final List<Actor> actors = await getActor(actorId);
    state = {...state, actorId: actors};
  }
}
