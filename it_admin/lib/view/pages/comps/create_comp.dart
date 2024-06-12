import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/data/competency.dart';
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
  // List<Level> levels = [
  //   Level(
  //       id: 1,
  //       skills: [Skill(id: 1, skillName: 'skillName', fileInfo: {})],
  //       levelName: 'level1',
  //       priority: 2,
  //       tests: [])
  // ];
  List<Level> levels = [];
  List<Skill> skills = [];
  List<String> files = [];
  List<int> priority = [-1, 1, 2, 3, 4, 5];
  List<Test> test = [];
  // List<String> files = ['readme.md', 'lesson1.md', 'lesson2.md'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // for (var i = 0; i < levels.length; i++) {
    //   levelsLength += ((pageList[levelVisibility[i]].levels?.length ?? 1) != 0)
    //       ? (pageList[levelVisibility[i]].levels?.length ?? 1) + 1
    //       : 1;
    // }

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
                                    files.isNotEmpty &&
                                    test.isNotEmpty) {
                                  alertDialog(context, 'Сохранить и выйти?',
                                      () {
                                    if (levels.length == test.length) {
                                      bool empty = false;
                                      for (var i = 0;
                                          i < levels.length && !false;
                                          i++) {
                                        if (levels[i].levelName == '') {
                                          empty = true;
                                        }
                                        if (levels[i].priority == -1) {
                                          empty = true;
                                        }
                                        for (var j = 0;
                                            j <
                                                    (levels[i].skills?.length ??
                                                        0) &&
                                                !empty;
                                            j++) {
                                          if (levels[i].skills?[j].skillName ==
                                              '') {
                                            empty = true;
                                          }
                                          if (levels[i]
                                                  .skills?[j]
                                                  .fileInfo
                                                  ?.contains('') ??
                                              false) {
                                            empty = true;
                                          }
                                        }
                                        for (var j = 0;
                                            j < levels[i].tests.length &&
                                                !empty;
                                            j++) {
                                          if (levels[i]
                                                  .tests[j]
                                                  .testQs
                                                  ?.contains('') ??
                                              false) {
                                            empty = true;
                                          }
                                          if (levels[i]
                                                  .tests[j]
                                                  .testAns
                                                  ?.containsValue('') ??
                                              false) {
                                            empty = true;
                                          }
                                          if (levels[i]
                                                  .tests[j]
                                                  .testCorr
                                                  ?.contains(-1) ??
                                              false) {
                                            empty = true;
                                          }
                                          if (levels[i].tests[j].testTime ==
                                              -1) {
                                            empty = true;
                                          }
                                          if (levels[i]
                                                  .tests[j]
                                                  .testQs
                                                  ?.length !=
                                              levels[i]
                                                  .tests[j]
                                                  .testCorr
                                                  ?.length) {
                                            empty = true;
                                          }
                                        }
                                      }
                                      if (!empty) {
                                        setState(() {
                                          adminController.compList.add(
                                              Competency(
                                                  id: adminController
                                                          .compList.isNotEmpty
                                                      ? adminController.compList
                                                              .last.id +
                                                          1
                                                      : 1,
                                                  levels: levels,
                                                  name: compName));
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        Get.snackbar('Ошибка',
                                            'Необходимо заполнить все поля');
                                      }
                                    } else {
                                      Get.snackbar('Ошибка',
                                          'Для каждого уровня должен быть составлен тест');
                                    }
                                  }, false);
                                } else {
                                  alertDialog(
                                      context,
                                      'Необходимо заполнить все поля и добавить тесты к каждому уровню',
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
                    height: levels.length * 295 + skills.length * 260,
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
                                              setState(() {
                                                levels.removeAt(index);
                                              });
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
                                            460,
                                    child: ListView.builder(
                                        itemCount:
                                            (levels[index].skills?.length ?? 1),
                                        itemBuilder: (context, j) {
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
                                                                setState(() {
                                                                  skills.remove(
                                                                      levels[index]
                                                                          .skills?[j]);
                                                                  levels[index]
                                                                      .skills
                                                                      ?.removeAt(
                                                                          j);
                                                                });
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
                                                          skills[j].skillName =
                                                              p0,
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
                                                      height: (levels[index]
                                                                  .skills?[j]
                                                                  .fileInfo
                                                                  ?.length ??
                                                              0) *
                                                          65,
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
                                                                  itemCount: levels[
                                                                              index]
                                                                          .skills?[
                                                                              j]
                                                                          .fileInfo
                                                                          ?.length ??
                                                                      0,
                                                                  itemBuilder:
                                                                      (context,
                                                                          l) {
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
                                                                                      levels[index].skills?[j].fileInfo?[l] ?? '',
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
                                                                                          files[l] = name != '' ? name : files[l];
                                                                                          levels[index].skills?[j].fileInfo?[l] = name != '' ? name : levels[index].skills?[j].fileInfo?[l] ?? '';
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
                                                                                          setState(() {
                                                                                            files.remove(levels[index].skills?[j].fileInfo?[l]);
                                                                                            levels[index].skills?[j].fileInfo?.removeAt(l);
                                                                                          });
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
                                                                              l < (levels[index].skills?[j].fileInfo?.length ?? 0) - 1,
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
                                                        var name =
                                                            await fileDialog(
                                                                context);
                                                        if (name != null) {
                                                          setState(() {
                                                            files.add(name);
                                                            levels[index]
                                                                .skills?[j]
                                                                .fileInfo
                                                                ?.add(name);
                                                          });
                                                        }
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
                                          fileInfo: []);
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
                                      var newTest = Test(
                                          id: levels[index].id,
                                          testQs: [],
                                          testAns: {},
                                          testCorr: [],
                                          testTime: 10);
                                      if (levels[index].tests.isEmpty) {
                                        await Get.to(() => TestPage(
                                            test: newTest,
                                            create: true,
                                            levelName:
                                                levels[index].levelName ??
                                                    'уровень'));
                                      } else {
                                        await Get.to(() => TestPage(
                                            test: levels[index].tests[0],
                                            create: true,
                                            levelName:
                                                levels[index].levelName ??
                                                    'уровень'));
                                      }
                                      if ((newTest.testQs?.isNotEmpty ??
                                              false) &&
                                          (newTest.testAns?.isNotEmpty ??
                                              false) &&
                                          (newTest.testCorr?.isNotEmpty ??
                                              false)) {
                                        newTest = adminController.tempTest;
                                        setState(() {
                                          if (levels[index].tests.isEmpty) {
                                            levels[index].tests.add(newTest);
                                            test.add(newTest);
                                          } else {
                                            levels[index].tests[0] = newTest;
                                            test[0] = newTest;
                                          }
                                        });
                                      }
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
                        id: levels.isNotEmpty ? levels.last.id + 1 : 1,
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
    String? newName;
    var newCompName = await showDialog(
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

  Future<String?> fileDialog(context) async {
    String? newFile;
    var newFileName = await showDialog(
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
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 600,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          child: Text(
                            'Выберите файл',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 25,
                                    decoration: TextDecoration.underline),
                          ),
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              newFile = result.files.first.name;
                              if (mounted) {
                                Navigator.pop(context, newFile);
                              }
                            } else {
                              Get.snackbar('Отмена', 'Файл не выбран');
                            }
                          },
                        ),
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
                    Navigator.pop(context, newFile);
                  }),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
    return newFileName;
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
