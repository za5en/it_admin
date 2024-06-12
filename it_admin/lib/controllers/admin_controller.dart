import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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
          id: 2,
          name: 'Java',
          levels: [
            UserLevel(
              id: 1,
              levelName: 'Уровень 0',
              tests: [
                UserTest(
                  id: 2,
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
      ],
    ),
    User(
      id: 2,
      email: 'za5en@yandex.ru',
      name: 'Власов Федор Андреевич',
      isActive: true,
      comps: [
        UserCompetency(id: 1, name: 'C#', levels: [
          UserLevel(
            id: 1,
            levelName: 'Уровень 0',
            tests: [
              UserTest(
                id: 1,
                testQs: [
                  'Какого типа наследования не существует?',
                  'Основные принципы ООП',
                  'Алгоритмическая сложность для чтения в Dictionary',
                  'Два ключевых оператора для работы с асинхронными вызовами'
                ],
                testAns: {
                  1: ['Одноуровневое', 'Двухуровневое', 'Многоуровневое'],
                  2: [
                    'инкапсуляция, наследование, полиморфизм и модуляция',
                    'инкапсуляция, наследование, полиморфизм и абстракция',
                    'конъюнкция, дизъюнкция, полиморфизм и импликация'
                  ],
                  3: ['O(n)', 'O(1)', 'O(log(n))'],
                  4: [
                    'await в заголовке метода, async при вызове метода',
                    'async в заголовке метода, await при вызове метода',
                    'await в заголовке, await и async при вызове'
                  ]
                },
                testCorr: [2, 2, 2, 2],
                userAns: [2, 2, 2, 2],
                testTime: 15,
                testTimeStart: DateTime.now(),
                solutionDuration: 12,
              )
            ],
            isCompleted: true,
          )
        ]),
      ],
    ),
    User(
      id: 3,
      email: 'sergeev@mail.ru',
      name: 'Сергеев Георгий Григорьевич',
      isActive: true,
      comps: [
        UserCompetency(id: 2, name: 'Java', levels: [
          UserLevel(
            id: 2,
            levelName: 'Уровень 0',
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
        ]),
      ],
    ),
    User(
      id: 4,
      email: 'shirobokov@mail.ru',
      name: 'Широбоков Артём Алексеевич',
      isActive: true,
      comps: [
        UserCompetency(id: 2, name: 'Java', levels: [
          UserLevel(
            id: 2,
            levelName: 'Уровень 0',
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
        ]),
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
        UserCompetency(id: 2, name: 'Java', levels: [
          UserLevel(
            id: 2,
            levelName: 'Уровень 0',
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
        ]),
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
      name: 'Стулин Илья Самвелович',
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
      name: 'Новгородов Пётр Михайлович',
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
              Skill(
                  id: 1,
                  skillName: 'ООП',
                  fileInfo: ['ООП_Основы.md', 'ООП_Принципы.md']),
              Skill(
                  id: 2,
                  skillName: 'Синтаксис',
                  fileInfo: ['Синтаксис_C#.md', 'Синтаксис_C#_доп.md']),
            ],
            levelName: 'Уровень 0',
            priority: 1,
            tests: [
              Test(
                id: 1,
                testQs: [
                  'Какого типа наследования не существует?',
                  'Основные принципы ООП',
                  'Алгоритмическая сложность для чтения в Dictionary',
                  'Два ключевых оператора для работы с асинхронными вызовами'
                ],
                testAns: {
                  1: ['Одноуровневое', 'Двухуровневое', 'Многоуровневое'],
                  2: [
                    'инкапсуляция, наследование, полиморфизм и модуляция',
                    'инкапсуляция, наследование, полиморфизм и абстракция',
                    'конъюнкция, дизъюнкция, полиморфизм и импликация'
                  ],
                  3: ['O(n)', 'O(1)', 'O(log(n))'],
                  4: [
                    'await в заголовке метода, async при вызове метода',
                    'async в заголовке метода, await при вызове метода',
                    'await в заголовке, await и async при вызове'
                  ]
                },
                testCorr: [2, 2, 2, 2],
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
            levelName: 'Уровень 0',
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
            levelName: 'Уровень 0',
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
            levelName: 'Уровень 0',
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
            levelName: 'Уровень 0',
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
            levelName: 'Уровень 0',
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

  var tempTest =
      Test(id: 1, testQs: [], testAns: {}, testCorr: [], testTime: 0);

  var authPage = '';

  var link = '';

  var cookie = '';

  var redirect = '';

  var code = '';

  User get user => _userData;
  Competency get comp => _compData;
  List<User> get users => userList;
  List<Competency> get comps => compList;
  Test get test => tempTest;

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

  void setTest(int id, List<String> testQs, Map testAns, List<int> testCorr,
      int testTime) {
    tempTest.id = id;
    tempTest.testQs = testQs;
    tempTest.testAns = testAns;
    tempTest.testCorr = testCorr;
    tempTest.testTime = testTime;
  }

  Future<int> auth() async {
    var response = await _remoteAdminServices.auth();
    authPage = response.body;
    var index = authPage.indexOf('action="');
    link = authPage.substring(index + 8);
    index = link.indexOf('"');
    link = link.substring(0, index);
    link = link.replaceAll('amp;', '');
    index = link.indexOf('/realms');
    link = link.substring(index);

    cookie = response.headers['set-cookie'] ?? '';
    // index = cookie.indexOf('KC_RESTART=');
    // cookie = cookie.substring(index + 11);
    cookie = cookie.replaceAll(
        'Version=1;Path=/realms/assistant-app/;Secure;HttpOnly;SameSite=None,',
        ' ');
    cookie = cookie.replaceAll(
        'Version=1;Path=/realms/assistant-app/;HttpOnly,', ' ');
    cookie = cookie.replaceAll(
        ';Version=1;Path=/realms/assistant-app/;HttpOnly', '');
    log(cookie);

    authPage = authPage.replaceAll(
        '/resources', 'http://192.168.31.93:8004/resources');
    authPage =
        authPage.replaceAll('"/realms', '"http://192.168.31.93:8004/realms');
    return response.statusCode;
  }

  Future<int> authPost(String login, String password) async {
    var response =
        await _remoteAdminServices.authPost(login, password, link, cookie);
    var location = response.headers['location'] ?? '';
    var index = location.indexOf('?');
    redirect = location.substring(0, index);
    index = location.indexOf('code=');
    code = location.substring(index + 5);

    return response.statusCode;
  }

  Future<int> authToken(String login, String password) async {
    var toEncode = '$login:$password';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(toEncode);
    var response = await _remoteAdminServices.authToken(code, redirect, encoded,
        login: login, password: password);

    return response.statusCode;
  }
}
