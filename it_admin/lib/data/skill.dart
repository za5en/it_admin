class Skill {
  Skill({
    required this.id,
    // required this.files,
    required this.skillName,
    required this.fileInfo,
  });

  int id;
  // List<File>? files;
  String? skillName;
  Map? fileInfo;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skillName: json["skillName"],
        fileInfo: json["fileInfo"],
      );
}
