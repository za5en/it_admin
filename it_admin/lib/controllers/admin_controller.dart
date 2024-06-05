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
    name: 'competency',
    levels: [
      Level(
          id: 1,
          skills: [
            Skill(id: 1, skillName: 'skill1', fileInfo: ['filename.md'])
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
      email: 'minakov@mail.ru',
      name: 'Минаков Михаил Андреевич',
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
      email: 'vlasov@mail.ru',
      name: 'Власов Федор Андреевич',
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
      email: 'sergeev@mail.ru',
      name: 'Сергеев Георгий Григорьевич',
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
      email: 'shirobokov@mail.ru',
      name: 'Широбоков Артём Алексеевич',
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
      email: 'stasov@mail.ru',
      name: 'Стасов Станислав Сергеевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 6,
      email: 'perevozchik@mail.ru',
      name: 'Перевозчиков Алексей Артёмович',
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
      id: 7,
      email: 'pirozhok@mail.ru',
      name: 'Пирожков Максим Евлампиевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 8,
      email: 'stulis@mail.ru',
      name: 'Табуреткин Иван Самвелович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 9,
      email: 'cherep@mail.ru',
      name: 'Череповец Василий Иванович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 10,
      email: 'nuance@mail.ru',
      name: 'Нюансов Пётр Михайлович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 11,
      email: 'batareika@mail.ru',
      name: 'Подберецкий Илья Дмитриевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 12,
      email: 'ruslang23@mail.ru',
      name: 'Губайдуллин Руслан Рустамович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 13,
      email: 'ustalovmv@mail.ru',
      name: 'Усталов Марсель Викторович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 14,
      email: 'ustalovvv@mail.ru',
      name: 'Усталов Виктор Вадимович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 15,
      email: 'ustalovvad@mail.ru',
      name: 'Усталов Вадим Васильевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 16,
      email: 'ustalovvas@mail.ru',
      name: 'Усталов Василий Витальевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 17,
      email: 'ustalovvit@mail.ru',
      name: 'Усталов Виталий Андреевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 18,
      email: 'svezhas@mail.ru',
      name: 'Свежов Андрей Сергеевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 19,
      email: 'svezhss@mail.ru',
      name: 'Свежов Сергей Семёнович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 20,
      email: 'cuminevsemenmaster@mail.ru',
      name: 'Каменев Семён Мастерович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 21,
      email: 'svezhsr@mail.ru',
      name: 'Свежов Семён Романович',
      isActive: true,
      comps: [],
    ),
    User(
      id: 22,
      email: 'svezhrn@mail.ru',
      name: 'Свежов Роман Николаевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 23,
      email: 'svezhnn@mail.ru',
      name: 'Свежов Никита Николаевич',
      isActive: true,
      comps: [],
    ),
    User(
      id: 24,
      email: 'svezhnr@mail.ru',
      name: 'Свежов Никита Романович',
      isActive: true,
      comps: [],
    ),
  ];

  var compList = [
    Competency(
      id: 1,
      name: 'C#',
      levels: [
        Level(
            id: 1,
            skills: [
              Skill(id: 1, skillName: 'skill1', fileInfo: ['filename.md'])
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
      name: 'Java',
      levels: [
        Level(
            id: 2,
            skills: [
              Skill(id: 2, skillName: 'skill1', fileInfo: ['filename.md'])
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
      name: 'C++',
      levels: [
        Level(
            id: 3,
            skills: [
              Skill(id: 3, skillName: 'skill1', fileInfo: ['filename.md'])
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
      name: 'DevOps',
      levels: [
        Level(
            id: 4,
            skills: [
              Skill(id: 4, skillName: 'skill1', fileInfo: ['filename.md'])
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
      name: 'Data Analyst',
      levels: [
        Level(
            id: 5,
            skills: [
              Skill(id: 5, skillName: 'skill1', fileInfo: ['filename.md'])
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
      name: 'Тестирование',
      levels: [
        Level(
            id: 6,
            skills: [
              Skill(id: 6, skillName: 'skill1', fileInfo: ['filename.md'])
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
