import 'skill.dart';

class Level {
  Level({
    required this.id,
    required this.skills,
    required this.levelName,
    required this.priority,
    required this.testId,
    required this.testQs,
    required this.testAns,
    required this.testCorr,
    required this.testTime,
    required this.solutionDuration,
  });

  int id;
  List<Skill>? skills;
  String? levelName;
  int? priority;
  int? testId;
  List<String>? testQs;
  Map? testAns;
  List<int>? testCorr;
  int? testTime;
  int? solutionDuration;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        skills: List<Skill>.from((json["skills"] ?? []).map((x) => x)),
        levelName: json["levelName"],
        priority: json["priority"],
        testId: json["testId"],
        testQs: List<String>.from((json["testQs"] ?? []).map((x) => x)),
        testAns: json["testAns"],
        testCorr: List<int>.from((json["testCorr"] ?? []).map((x) => x)),
        testTime: json["testTime"],
        solutionDuration: json["solutionDuration"],
      );
}
