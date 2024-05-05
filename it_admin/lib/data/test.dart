class Test {
  Test({
    required this.id,
    required this.testQs,
    required this.testAns,
    required this.testCorr,
    required this.testTime,
  });

  int id;
  List<String>? testQs;
  Map? testAns;
  List<int>? testCorr;
  int? testTime;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        testQs: List<String>.from((json["testQs"] ?? []).map((x) => x)),
        testAns: json["testAns"],
        testCorr: List<int>.from((json["testCorr"] ?? []).map((x) => x)),
        testTime: json["testTime"],
      );
}

class UserTest {
  UserTest({
    required this.id,
    required this.testQs,
    required this.testAns,
    required this.testCorr,
    required this.userAns,
    required this.testTime,
    required this.testTimeStart,
    required this.solutionDuration,
  });

  int id;
  List<String>? testQs;
  Map? testAns;
  List<int>? testCorr;
  List<int>? userAns;
  int? testTime;
  DateTime? testTimeStart;
  int? solutionDuration;

  factory UserTest.fromJson(Map<String, dynamic> json) => UserTest(
        id: json["id"],
        testQs: List<String>.from((json["testQs"] ?? []).map((x) => x)),
        testAns: json["testAns"],
        testCorr: List<int>.from((json["testCorr"] ?? []).map((x) => x)),
        userAns: List<int>.from((json["userAns"] ?? []).map((x) => x)),
        testTime: json["testTime"],
        testTimeStart: json["testTimeStart"],
        solutionDuration: json["solutionDuration"],
      );
}
