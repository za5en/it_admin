import 'level.dart';

class Competency {
  Competency({
    required this.id,
    required this.levels,
    required this.name,
  });

  int id;
  List<Level>? levels;
  String? name;

  factory Competency.fromJson(Map<String, dynamic> json) => Competency(
        id: json["id"],
        name: json["name"],
        levels: List<Level>.from((json["levels"] ?? []).map((x) => x)),
      );
}
