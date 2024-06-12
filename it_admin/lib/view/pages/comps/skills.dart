import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/data/test.dart';
import 'package:it_admin/view/pages/comps/test_page.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/level.dart';
import '../../../data/skill.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_elevated_button.dart';
import '../login.dart';

class Skills extends StatefulWidget {
  const Skills({super.key, required this.compId, required this.level});

  final int compId;
  final Level level;

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  var adminController = Get.find<AdminController>();
  var levelName = '';
  List<int> fileVisibility = [];
  @override
  Widget build(BuildContext context) {
    int filesLength = 0;
    List<Skill> skills = [];
    var competency = adminController.compList
        .firstWhere((element) => element.id == widget.compId);
    var level = competency.levels
            ?.firstWhere((element) => element.id == widget.level.id) ??
        Level(
            id: 1,
            skills: [],
            levelName: 'level',
            priority: 1,
            tests: [
              Test(id: 1, testQs: [], testAns: {}, testCorr: [], testTime: 5)
            ]);
    skills = level.skills ?? [];

    for (var i = 0; i < fileVisibility.length; i++) {
      filesLength += ((skills[fileVisibility[i]].fileInfo?.length ?? 1) != 0)
          ? (skills[fileVisibility[i]].fileInfo?.length ?? 1) + 1
          : 1;
    }

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
                        padding: EdgeInsets.only(left: w * 0.01, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Image.asset(
                                'assets/images/close.png',
                                height: 35.0,
                              ),
                              onTap: () {
                                // alertDialog(context, 'Выйти без сохранения?',
                                //     () {
                                //   Navigator.pop(context);
                                Navigator.pop(context);
                                // });
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Text(
                                levelName != ''
                                    ? levelName
                                    : widget.level.levelName ?? 'уровень',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600)),
                            InkWell(
                              child: Image.asset(
                                'assets/images/edit.png',
                                color: Theme.of(context).colorScheme.primary,
                                height: 45,
                              ),
                              onTap: () async {
                                var name = await editDialog(
                                    context, 'Введите название уровня:');
                                if (name != null) {
                                  // levelName = name;
                                  bool find = false;
                                  for (var i = 0;
                                      i < adminController.compList.length &&
                                          !find;
                                      i++) {
                                    for (var j = 0;
                                        j <
                                                (adminController.compList[i]
                                                        .levels?.length ??
                                                    0) &&
                                            !find;
                                        j++) {
                                      if (adminController
                                              .compList[i].levels?[j].id ==
                                          widget.level.id) {
                                        setState(() {
                                          find = true;
                                          adminController.compList[i].levels?[j]
                                              .levelName = name;
                                        });
                                      }
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.01, top: 15),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          // child: InkWell(
                          //   child: Image.asset(
                          //     'assets/images/save.png',
                          //     height: 35.0,
                          //   ),
                          //   onTap: () {
                          //     alertDialog(context, 'Сохранить и выйти?', () {
                          //       Navigator.pop(context);
                          //       Navigator.pop(context);
                          //       //add to the admincontroller
                          //     });
                          //   },
                          // ),
                          child: SizedBox(
                            height: 35.0,
                            width: 35.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Container(
                  height: skills.length * 65 + filesLength * 60.5,
                  width: w * 0.98,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          itemCount: skills.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0, right: 30.0),
                                              child: Text(
                                                skills[index].skillName ??
                                                    'skill',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 30),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (fileVisibility
                                                    .contains(index)) {
                                                  fileVisibility.remove(index);
                                                } else {
                                                  fileVisibility.add(index);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            child: Image.asset(
                                              'assets/images/edit.png',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              height: 45,
                                            ),
                                            onTap: () async {
                                              var name = await editDialog(
                                                  context,
                                                  'Введите название навыка:');
                                              if (name != null) {
                                                skills[index].skillName = name;
                                                bool find = false;
                                                for (var i = 0;
                                                    i <
                                                            adminController
                                                                .compList
                                                                .length &&
                                                        !find;
                                                    i++) {
                                                  if (adminController
                                                          .compList[i].id ==
                                                      widget.compId) {
                                                    for (var j = 0;
                                                        j <
                                                                (adminController
                                                                        .compList[
                                                                            i]
                                                                        .levels
                                                                        ?.length ??
                                                                    0) &&
                                                            !find;
                                                        j++) {
                                                      if (adminController
                                                              .compList[i]
                                                              .levels?[j]
                                                              .id ==
                                                          widget.level.id) {
                                                        for (var k = 0;
                                                            k <
                                                                    (adminController
                                                                            .compList[i]
                                                                            .levels?[j]
                                                                            .skills
                                                                            ?.length ??
                                                                        1) &&
                                                                !find;
                                                            k++) {
                                                          if (adminController
                                                                  .compList[i]
                                                                  .levels?[j]
                                                                  .skills?[k]
                                                                  .id ==
                                                              skills[index]
                                                                  .id) {
                                                            setState(() {
                                                              find = true;
                                                              adminController
                                                                  .compList[i]
                                                                  .levels?[j]
                                                                  .skills?[k]
                                                                  .skillName = name;
                                                            });
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: InkWell(
                                              child: Image.asset(
                                                'assets/images/bin.png',
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                height: 35,
                                              ),
                                              onTap: () {
                                                alertDialog(
                                                    context, 'Удалить навык?',
                                                    () {
                                                  bool find = false;
                                                  for (var i = 0;
                                                      i <
                                                              adminController
                                                                  .compList
                                                                  .length &&
                                                          !find;
                                                      i++) {
                                                    if (adminController
                                                            .compList[i].id ==
                                                        widget.compId) {
                                                      for (var j = 0;
                                                          j <
                                                                  (adminController
                                                                          .compList[
                                                                              i]
                                                                          .levels
                                                                          ?.length ??
                                                                      0) &&
                                                              !find;
                                                          j++) {
                                                        if (adminController
                                                                .compList[i]
                                                                .levels?[j]
                                                                .id ==
                                                            widget.level.id) {
                                                          setState(() {
                                                            find = true;
                                                            adminController
                                                                .compList[i]
                                                                .levels?[j]
                                                                .skills
                                                                ?.remove(skills[
                                                                    index]);
                                                          });
                                                        }
                                                      }
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: fileVisibility.contains(index),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Divider(
                                      thickness: 0.0,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: fileVisibility.contains(index) &&
                                      (skills[index].fileInfo?.isNotEmpty ??
                                          false),
                                  child: SizedBox(
                                    height:
                                        (skills[index].fileInfo?.length ?? 0) *
                                            61,
                                    child: ListView.builder(
                                      itemCount:
                                          (skills[index].fileInfo?.length ?? 0),
                                      itemBuilder: (context, j) {
                                        return Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50.0),
                                                  child: Container(
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 40.0,
                                                                    right:
                                                                        40.0),
                                                                child: Text(
                                                                  skills[index]
                                                                              .fileInfo?[
                                                                          j] ??
                                                                      'filename.md',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              30),
                                                                ),
                                                              ),
                                                              onTap: () {},
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/edit.png',
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                height: 45,
                                                              ),
                                                              onTap: () async {
                                                                var name =
                                                                    await editDialog(
                                                                        context,
                                                                        'Изменить название файла:');
                                                                if (name !=
                                                                    null) {
                                                                  // setState(() {
                                                                  //   skills[index]
                                                                  //           .fileInfo?[
                                                                  //       j] = name;
                                                                  // });
                                                                  bool find =
                                                                      false;
                                                                  for (var i =
                                                                          0;
                                                                      i < adminController.compList.length &&
                                                                          !find;
                                                                      i++) {
                                                                    if (adminController
                                                                            .compList[
                                                                                i]
                                                                            .id ==
                                                                        widget
                                                                            .compId) {
                                                                      for (var k =
                                                                              0;
                                                                          k < (adminController.compList[i].levels?.length ?? 0) &&
                                                                              !find;
                                                                          k++) {
                                                                        if (adminController.compList[i].levels?[k].id ==
                                                                            widget.level.id) {
                                                                          for (var l = 0;
                                                                              l < (adminController.compList[i].levels?[k].skills?.length ?? 1) && !find;
                                                                              l++) {
                                                                            if (adminController.compList[i].levels?[k].skills?[l].id ==
                                                                                skills[index].id) {
                                                                              setState(() {
                                                                                find = true;
                                                                                skills[index].fileInfo?[j] = name;
                                                                              });
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 30.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15.0),
                                                              child: InkWell(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/bin.png',
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  height: 35,
                                                                ),
                                                                onTap: () {
                                                                  alertDialog(
                                                                      context,
                                                                      'Удалить файл?',
                                                                      () {
                                                                    bool find =
                                                                        false;
                                                                    for (var i =
                                                                            0;
                                                                        i < adminController.compList.length &&
                                                                            !find;
                                                                        i++) {
                                                                      if (adminController
                                                                              .compList[i]
                                                                              .id ==
                                                                          widget.compId) {
                                                                        for (var k =
                                                                                0;
                                                                            k < (adminController.compList[i].levels?.length ?? 0) &&
                                                                                !find;
                                                                            k++) {
                                                                          if (adminController.compList[i].levels?[k].id ==
                                                                              widget.level.id) {
                                                                            for (var l = 0;
                                                                                l < (adminController.compList[i].levels?[k].skills?.length ?? 1) && !find;
                                                                                l++) {
                                                                              if (adminController.compList[i].levels?[k].skills?[l].id == skills[index].id) {
                                                                                setState(() {
                                                                                  find = true;
                                                                                  adminController.compList[i].levels?[k].skills?[l].fileInfo?.remove(skills[index].fileInfo?[j]);
                                                                                });
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 1,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 50.0),
                                                  child: Divider(
                                                    thickness: 0.0,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: fileVisibility.contains(index),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: InkWell(
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Загрузить материалы',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(fontSize: 30),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            var name =
                                                await fileDialog(context);
                                            if (name != null) {
                                              bool find = false;
                                              for (var i = 0;
                                                  i <
                                                          adminController
                                                              .compList
                                                              .length &&
                                                      !find;
                                                  i++) {
                                                if (adminController
                                                        .compList[i].id ==
                                                    widget.compId) {
                                                  for (var k = 0;
                                                      k <
                                                              (adminController
                                                                      .compList[
                                                                          i]
                                                                      .levels
                                                                      ?.length ??
                                                                  0) &&
                                                          !find;
                                                      k++) {
                                                    if (adminController
                                                            .compList[i]
                                                            .levels?[k]
                                                            .id ==
                                                        widget.level.id) {
                                                      for (var l = 0;
                                                          l <
                                                                  (adminController
                                                                          .compList[
                                                                              i]
                                                                          .levels?[
                                                                              k]
                                                                          .skills
                                                                          ?.length ??
                                                                      1) &&
                                                              !find;
                                                          l++) {
                                                        if (adminController
                                                                .compList[i]
                                                                .levels?[k]
                                                                .skills?[l]
                                                                .id ==
                                                            skills[index].id) {
                                                          setState(() {
                                                            find = true;
                                                            adminController
                                                                .compList[i]
                                                                .levels?[k]
                                                                .skills?[l]
                                                                .fileInfo
                                                                ?.add(name);
                                                          });
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: index < skills.length - 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: fileVisibility.contains(index)
                                            ? 0.0
                                            : 10.0,
                                        bottom: 10.0),
                                    child: const Divider(
                                      thickness: 0.0,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ),
              AElevatedButtonExtended(
                text: 'Добавить новый навык',
                textSize: 30,
                width: w * 0.98,
                pad: false,
                onPressed: () async {
                  var name =
                      await editDialog(context, 'Введите название навыка:');
                  if (name != null) {
                    setState(() {
                      skills.add(Skill(
                          id: skills.isNotEmpty ? skills.last.id + 1 : 1,
                          skillName: name,
                          fileInfo: []));
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AElevatedButtonExtended(
                  text: widget.level.tests.isNotEmpty
                      ? 'Изменить тест'
                      : 'Добавить тест',
                  textSize: 30,
                  width: w * 0.98,
                  pad: false,
                  onPressed: () async {
                    if (widget.level.tests.isNotEmpty) {
                      Get.to(() => TestPage(
                          test: widget.level.tests[0],
                          create: false,
                          levelName: widget.level.levelName ?? 'уровень'));
                    } else {
                      Get.to(() => TestPage(
                          test: Test(
                              id: widget.level.id,
                              testQs: [],
                              testAns: {},
                              testCorr: [],
                              testTime: 10),
                          create: true,
                          levelName: widget.level.levelName ?? 'уровень'));
                    }
                  },
                ),
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

  alertDialog(context, message, onPressed) {
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
            content: Row(
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
                              newFile = result.files.single.name;
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
