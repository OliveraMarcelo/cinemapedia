
import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// este repositorio es inmutable
/* 
este provider sera de solo lectura
este datasource es el origen de dato para que funcione este
movierepositoryprovider

su objetivo es proporcionar 
a todos los demas providers que tengo ahi adentro toda la informacion
para que puedan consultar la informacion de MovieRepositoryImpl 
 */


final movieRepositorProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});


/* 
NOS OFRECCE LLAMAR LAS FUNCIONES DE  MovieRepositoryImpl NOS OFRECE LA POSIBLIDFAD DE LLAMAR FUNCIONES 
LA CUAL TIENE LE ACCESO AL MoviedbDatasource PARA REALIZAR LA BUSQUEDA 
 */