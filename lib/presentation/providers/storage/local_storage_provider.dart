import 'package:cinemapedia/infraestructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/* 
autodispose lo usan cuando se deja de utilizar este provider en el widget lo deja en el estado inicial 
fmaily te permite recibir un argumento
 */

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
},);