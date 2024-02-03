// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;
  
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
  });

}
