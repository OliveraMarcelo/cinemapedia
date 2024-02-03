import 'dart:convert';

class CreditsResponse {
    int? id;
    List<Cast>? cast;
    List<Crew>? crew;

    CreditsResponse({
        this.id,
        this.cast,
        this.crew,
    });

    factory CreditsResponse.fromRawJson(String str) => CreditsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
        crew: json["crew"] == null ? [] : List<Crew>.from(json["crew"]!.map((x) => Crew.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toJson())),
    };
}

class Cast {
    bool? adult;
    int? gender;
    int? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;
    int? order;

    Cast({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
    });

    factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
    };
}

class Crew {
    bool? adult;
    int? gender;
    int? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    String? creditId;
    String? department;
    String? job;

    Crew({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.creditId,
        this.department,
        this.job,
    });

    factory Crew.fromRawJson(String str) => Crew.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        creditId: json["credit_id"],
        department: json["department"],
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "credit_id": creditId,
        "department": department,
        "job": job,
    };
}