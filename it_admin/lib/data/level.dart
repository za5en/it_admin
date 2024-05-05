import 'skill.dart';
import 'test.dart';

class Level {
  Level({
    required this.id,
    required this.skills,
    required this.levelName,
    required this.priority,
    required this.tests,
  });

  int id;
  List<Skill>? skills;
  String? levelName;
  int? priority;
  List<Test> tests;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        skills: List<Skill>.from((json["skills"] ?? []).map((x) => x)),
        levelName: json["levelName"],
        priority: json["priority"],
        tests: List<Test>.from((json["tests"] ?? []).map((x) => x)),
      );
}
