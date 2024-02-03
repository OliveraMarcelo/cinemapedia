/* 
cual es el objetivo del mapper ? 
es que tengamos la conversion 
de como luce algun objeto(datasource que utilizaremos externo) 
a nuestro tipo de objeto personalizado(datasource) que usamos en la app 
una barrera protectora
 */
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor CastToEntity(Cast cast) => Actor(
      id: cast.id!,
      name: cast.name!,
      character: cast.character,
      profilePath: 
          (cast.profilePath != null)
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
          : 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  );
}
