import 'level.dart';

class User {
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.isActive,
    required this.comps,
  });

  int id;
  String? email;
  String? name;
  bool? isActive;
  List<UserCompetency>? comps;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        isActive: json["isActive"],
        comps: List<UserCompetency>.from((json["comps"] ?? []).map((x) => x)),
      );
}

class UserCompetency {
  UserCompetency({
    required this.id,
    required this.name,
    required this.isCompleted,
    required this.levels,
  });

  int id;
  String? name;
  bool? isCompleted;
  List<Level>? levels;
}
