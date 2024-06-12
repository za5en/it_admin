import 'test.dart';

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
    required this.levels,
  });

  int id;
  String? name;
  List<UserLevel> levels;

  factory UserCompetency.fromJson(Map<String, dynamic> json) => UserCompetency(
        id: json["id"],
        name: json["levelName"],
        levels: List<UserLevel>.from((json["tests"] ?? []).map((x) => x)),
      );
}

class UserLevel {
  UserLevel({
    required this.id,
    required this.levelName,
    required this.isCompleted,
    required this.tests,
  });

  int id;
  String? levelName;
  bool? isCompleted;
  List<UserTest>? tests;

  factory UserLevel.fromJson(Map<String, dynamic> json) => UserLevel(
        id: json["id"],
        levelName: json["levelName"],
        isCompleted: json["isCompleted"],
        tests: List<UserTest>.from((json["tests"] ?? []).map((x) => x)),
      );
}
