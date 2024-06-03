import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/data/skill.dart';
import 'package:it_admin/data/test.dart';
import 'package:it_admin/view/pages/comps/test_page.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/level.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_drop_down.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_pop_up.dart';
import '../../widgets/a_svg_icon.dart';
import '../login.dart';

class CreateComp extends StatefulWidget {
  const CreateComp({super.key});

  @override
  State<CreateComp> createState() => _CreateCompState();
}

class _CreateCompState extends State<CreateComp> {
  var adminController = Get.find<AdminController>();
  var compName = '';
  List<Level> levels = [
    Level(
        id: 1,
        skills: [Skill(id: 1, skillName: 'skillName', fileInfo: {})],
        levelName: 'level1',
        priority: 2,
        tests: [])
  ];
  List<Skill> skills = [];
  List<int> priority = [-1, 1, 2, 3, 4, 5];
  List<String> files = ['readme.md', 'lesson1.md', 'lesson2.md'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AAppBar(
        nonDefWidth: true,
        toolbarHeight: 20,
        title: InkWell(
          child: Text(
            'IT-тренер',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 18, decoration: TextDecoration.underline),
          ),
          onTap: () {
            Get.until((route) => Get.currentRoute == '/comps');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.015, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Image.asset('assets/images/close.png',
                                  height: 35.0),
                              onTap: () {
                                alertDialog(context, 'Выйти без сохранения?',
                                    () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, false);
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text('Новая компетенция',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 35, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.015, top: 15),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Image.asset('assets/images/save.png',
                                  height: 35.0),
                              onTap: () {
                                if (compName != '' &&
                                    levels.isNotEmpty &&
                                    skills.isNotEmpty &&
                                    files.isNotEmpty) {
                                  alertDialog(context, 'Сохранить и выйти?',
                                      () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    //add to the admincontroller
                                  }, false);
                                } else {
                                  alertDialog(
                                      context,
                                      'Нужно добавить хотя бы один уровень и заполнить поля',
                                      () {},
                                      true);
                                }
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: w * 0.015, top: 35.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: LoginTextField(
                        text: 'Название',
                        onChanged: (p0) => compName = p0,
                        enabled: true,
                        width: w * 0.95,
                        validator: (value) {
                          if (value == null) {
                            return 'Это поле должно быть заполнено';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 35.0, left: w * 0.01, right: w * 0.01),
                child: Visibility(
                  // visible: levels.isNotEmpty,
                  child: SizedBox(
                    height: levels.length * 700,
                    child: ListView.builder(
                      itemCount: levels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: w * 0.01,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text('Новый уровень',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: InkWell(
                                          child: Image.asset(
                                            'assets/images/close.png',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            height: 35,
                                          ),
                                          onTap: () {
                                            alertDialog(
                                                context, 'Удалить уровень?',
                                                () {
                                              Navigator.pop(context);
                                            }, false);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w * 0.01),
                                        child: Row(
                                          children: [
                                            LoginTextField(
                                              width: w * 0.65,
                                              text: 'Название',
                                              onChanged: (p0) =>
                                                  levels[index].levelName = p0,
                                              enabled: true,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Это поле должно быть заполнено';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: w * 0.008),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: ParamWithDropDown(
                                            popupSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            popupMenuButton: Container(
                                              width: w * 0.25,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                        levels[index]
                                                                    .priority ==
                                                                -1
                                                            ? 'Приоритет'
                                                            : levels[index]
                                                                .priority
                                                                .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                fontSize: 20)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15.0),
                                                    child: ASvgIcon(
                                                      assetName:
                                                          'assets/images/triangle.svg',
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onTertiaryContainer,
                                                      height: 28,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onSelected: (value) {
                                              setState(() {
                                                levels[index].priority =
                                                    priority[value];
                                              });
                                            },
                                            popupMenuData: [
                                              for (var i = 0;
                                                  i < priority.length;
                                                  i++)
                                                APopupMenuData(
                                                  child: Text(
                                                      i == 0
                                                          ? 'Приоритет'
                                                          : priority[i]
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  // visible: levels.isNotEmpty,
                                  child: SizedBox(
                                    height:
                                        (levels[index].skills?.length ?? 1) *
                                            410,
                                    child: ListView.builder(
                                        itemCount:
                                            (levels[index].skills?.length ?? 1),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: w * 0.025,
                                                right: w * 0.025,
                                                bottom: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                w * 0.01),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: w * 0.01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15.0),
                                                          child: Text(
                                                              'Новый навык',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          35,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: InkWell(
                                                            child: Image.asset(
                                                              'assets/images/close.png',
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              height: 35,
                                                            ),
                                                            onTap: () {
                                                              alertDialog(
                                                                  context,
                                                                  'Удалить навык?',
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                              }, false);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: w * 0.01),
                                                    child: LoginTextField(
                                                      width: w * 0.9,
                                                      text: 'Название',
                                                      onChanged: (p0) =>
                                                          levels[index]
                                                              .levelName = p0,
                                                      enabled: true,
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return 'Это поле должно быть заполнено';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0),
                                                    child: Container(
                                                      height: files.length * 65,
                                                      width: w * 0.9,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onTertiaryContainer,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    25)),
                                                      ),
                                                      child: Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0),
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: files
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10.0,
                                                                              right: 10.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                                                                    child: Text(
                                                                                      files[index],
                                                                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  InkWell(
                                                                                    child: Image.asset(
                                                                                      'assets/images/edit.png',
                                                                                      color: Theme.of(context).colorScheme.primary,
                                                                                      height: 45,
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      var name = await editDialog(context, 'Введите название файла:');
                                                                                      if (name != null) {
                                                                                        setState(() {
                                                                                          files[index] = name != '' ? name : files[index];
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 30.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 5.0),
                                                                                    child: InkWell(
                                                                                      child: Image.asset(
                                                                                        'assets/images/bin.png',
                                                                                        color: Theme.of(context).colorScheme.primary,
                                                                                        height: 35,
                                                                                      ),
                                                                                      onTap: () {
                                                                                        alertDialog(context, 'Удалить файл?', () {
                                                                                          Navigator.pop(context);
                                                                                        }, false);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Visibility(
                                                                          visible:
                                                                              index < files.length - 1,
                                                                          child:
                                                                              const Divider(
                                                                            thickness:
                                                                                0.0,
                                                                            height:
                                                                                19,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child:
                                                        AElevatedButtonExtended(
                                                      text:
                                                          'Загрузить материалы',
                                                      textSize: 30,
                                                      width: w * 0.9,
                                                      pad: false,
                                                      onPressed: () async {
                                                        setState(() {
                                                          //add file
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                AElevatedButtonExtended(
                                  text: 'Добавить новый навык',
                                  textSize: 30,
                                  width: w * 0.9,
                                  pad: false,
                                  onPressed: () async {
                                    setState(() {
                                      var skill = Skill(
                                          id: levels[index].skills!.isNotEmpty
                                              ? levels[index].skills!.last.id +
                                                  1
                                              : 1,
                                          skillName: '',
                                          fileInfo: {});
                                      levels[index].skills?.add(skill);
                                      skills.add(skill);
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 20.0),
                                  child: AElevatedButtonExtended(
                                    text: levels[index].tests.isEmpty
                                        ? 'Добавить новый тест'
                                        : 'Изменить тест',
                                    textSize: 30,
                                    width: w * 0.9,
                                    pad: false,
                                    onPressed: () async {
                                      setState(() {
                                        var test = Test(
                                            id: levels[index].id,
                                            testQs: [],
                                            testAns: {},
                                            testCorr: [],
                                            testTime: 10);
                                        Get.to(() => TestPage(
                                            test: test,
                                            levelName:
                                                levels[index].levelName ??
                                                    'level'));
                                        //return test info
                                        levels[index].tests.add(test);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              AElevatedButtonExtended(
                text: 'Добавить новый уровень',
                textSize: 30,
                width: w * 0.98,
                pad: false,
                onPressed: () async {
                  setState(() {
                    levels.add(Level(
                        id: levels.last.id + 1,
                        skills: [],
                        levelName: '',
                        priority: -1,
                        tests: []));
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: h * 0.01),
                child: Text(
                  'система администрирования сервиса развития навыков сотрудников IT компаний, 2024',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  alertDialog(context, message, onPressed, error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            title: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.01,
                ),
                child: SizedBox(
                  height: 150,
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                )),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            content: error
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        getButton('Ок', () {
                          Navigator.pop(context);
                        }),
                      ])
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        getButton('Нет', () {
                          Navigator.pop(context);
                        }),
                        getButton('Да', onPressed),
                      ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

  Future<String?> editDialog(context, message) async {
    var newCompName = await showDialog(
        context: context,
        builder: (BuildContext context) {
          String? newName;
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            title: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.01,
                ),
                child: SizedBox(
                  height: 150,
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 25),
                      ),
                      LoginTextField(
                        text: 'Название',
                        onChanged: (p0) => newName = p0,
                        enabled: true,
                      ),
                    ],
                  ),
                )),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getButton('Отмена', () {
                    Navigator.pop(context);
                  }),
                  getButton('Ок', () {
                    Navigator.pop(context, newName);
                  }),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
    return newCompName;
  }

  Widget getButton(String text, Function() onPressed) => Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.015),
            child: Text(
              text,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 25),
            ),
          ),
        ),
      );
}
