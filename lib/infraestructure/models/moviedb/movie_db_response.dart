import 'dart:convert';

import 'package:cinemapedia/infraestructure/models/moviedb/movie_moviedb.dart';


class MovieDbResponse {
    Dates? dates;
    int? page;
    List<MovieMovieDB>? results;
    int? totalPages;
    int? totalResults;

    MovieDbResponse({
        this.dates,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory MovieDbResponse.fromRawJson(String str) => MovieDbResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: json["results"] == null ? [] : List<MovieMovieDB>.from(json["results"]!.map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    DateTime? maximum;
    DateTime? minimum;

    Dates({
        this.maximum,
        this.minimum,
    });

    factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
    };
}
