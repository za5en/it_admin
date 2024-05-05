import 'dart:async';

import 'package:get/get.dart';
import 'package:it_admin/data/competency.dart';
import 'package:it_admin/data/level.dart';
import 'package:it_admin/data/skill.dart';
import 'package:it_admin/data/test.dart';

import '../data/data.dart';
import '../data/user.dart';
import '../services/remote_admin_services.dart';

class AdminController extends GetxController {
  final _remoteAdminServices = const RemoteAdminServices();

  var _userData = User(
    id: 1,
    email: 'mail@mail.ml',
    name: 'userName1',
    isActive: true,
    comps: [],
  );

  var _compData = Competency(
    id: 1,
    name: 'competency1',
    levels: [
      Level(
          id: 1,
          skills: [
            Skill(id: 1, skillName: 'skill1', fileInfo: {1: 'filename.md'})
          ],
          levelName: 'level1',
          priority: 1,
          tests: [
            Test(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              testTime: 15,
            )
          ])
    ],
  );

  var userList = [
    User(
      id: 1,
      email: 'mail@mail.ml',
      name: 'userName1',
      isActive: true,
      comps: [
        UserCompetency(
          id: 1,
          name: 'competency1',
          tests: [
            UserTest(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              userAns: [2, 3, 1, 1],
              testTime: 15,
              testTimeStart: DateTime.now(),
              solutionDuration: 12,
            )
          ],
          isCompleted: true,
        ),
      ],
    ),
    User(
      id: 2,
      email: 'mail1@mail.ml',
      name: 'userName2',
      isActive: true,
      comps: [
        UserCompetency(
          id: 1,
          name: 'competency1',
          tests: [
            UserTest(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              userAns: [2, 3, 1, 1],
              testTime: 15,
              testTimeStart: DateTime.now(),
              solutionDuration: 12,
            )
          ],
          isCompleted: true,
        ),
      ],
    ),
    User(
      id: 3,
      email: 'mail2@mail.ml',
      name: 'userName3',
      isActive: true,
      comps: [
        UserCompetency(
          id: 1,
          name: 'competency1',
          tests: [
            UserTest(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              userAns: [2, 3, 1, 1],
              testTime: 15,
              testTimeStart: DateTime.now(),
              solutionDuration: 12,
            )
          ],
          isCompleted: true,
        ),
      ],
    ),
    User(
      id: 4,
      email: 'mail3@mail.ml',
      name: 'userName4',
      isActive: true,
      comps: [
        UserCompetency(
          id: 1,
          name: 'competency1',
          tests: [
            UserTest(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              userAns: [2, 3, 1, 1],
              testTime: 15,
              testTimeStart: DateTime.now(),
              solutionDuration: 12,
            )
          ],
          isCompleted: true,
        ),
      ],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 6,
      email: 'mail5@mail.ml',
      name: 'userName6',
      isActive: true,
      comps: [
        UserCompetency(
          id: 1,
          name: 'competency1',
          tests: [
            UserTest(
              id: 1,
              testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
              testAns: {
                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
              },
              testCorr: [2, 3, 1, 2],
              userAns: [2, 3, 1, 1],
              testTime: 15,
              testTimeStart: DateTime.now(),
              solutionDuration: 12,
            )
          ],
          isCompleted: true,
        ),
      ],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
    User(
      id: 5,
      email: 'mail4@mail.ml',
      name: 'userName5',
      isActive: true,
      comps: [],
    ),
  ];

  var compList = [
    Competency(
      id: 1,
      name: 'competency1',
      levels: [
        Level(
            id: 1,
            skills: [
              Skill(id: 1, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 1,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
    Competency(
      id: 2,
      name: 'competency2',
      levels: [
        Level(
            id: 2,
            skills: [
              Skill(id: 2, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 2,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
    Competency(
      id: 3,
      name: 'competency3',
      levels: [
        Level(
            id: 3,
            skills: [
              Skill(id: 3, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 3,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
    Competency(
      id: 4,
      name: 'competency4',
      levels: [
        Level(
            id: 4,
            skills: [
              Skill(id: 4, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 4,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
    Competency(
      id: 5,
      name: 'competency5',
      levels: [
        Level(
            id: 5,
            skills: [
              Skill(id: 5, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 5,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
    Competency(
      id: 6,
      name: 'competency6',
      levels: [
        Level(
            id: 6,
            skills: [
              Skill(id: 6, skillName: 'skill1', fileInfo: {1: 'filename.md'})
            ],
            levelName: 'level1',
            priority: 1,
            tests: [
              Test(
                id: 6,
                testQs: ['Вопрос 1', 'Вопрос 2', 'Вопрос 3', 'Вопрос 4'],
                testAns: {
                  1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                  4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                },
                testCorr: [2, 3, 1, 2],
                testTime: 15,
              )
            ])
      ],
    ),
  ];

  User get user => _userData;
  Competency get comp => _compData;
  List<User> get users => userList;
  List<Competency> get comps => compList;

  AdminController();

  Future<void> getInfo(String userId, String password) async {
    var response = await _remoteAdminServices.getInfo(
      userId,
      password,
    );
    var data = Data.fromJson(response.body);
    if (data.isSuccess) {
      _userData = User.fromJson(data.data);
      _compData = Competency.fromJson(data.data);
    }
  }
}
