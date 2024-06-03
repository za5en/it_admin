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
  @override
  Widget build(BuildContext context) {
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
                                alertDialog(context, 'Выйти без сохранения?',
                                    () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
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
                                  setState(() {
                                    levelName = name;
                                    bool found = false;
                                    for (var i = 0;
                                        i < adminController.compList.length &&
                                            !found;
                                        i++) {
                                      for (var j = 0;
                                          j <
                                                  (adminController.compList[i]
                                                          .levels?.length ??
                                                      0) &&
                                              !found;
                                          j++) {
                                        if (adminController
                                                .compList[i].levels?[j].id ==
                                            widget.level.id) {
                                          adminController.compList[i].levels?[j]
                                              .levelName = name;
                                          found = true;
                                        }
                                      }
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.01, top: 15),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Image.asset(
                                'assets/images/save.png',
                                height: 35.0,
                              ),
                              onTap: () {
                                alertDialog(context, 'Сохранить и выйти?', () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  //add to the admincontroller
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Container(
                  height: skills.length * 65,
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
                                                //unhide files (bool)
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
                                                setState(() {
                                                  skills[index].skillName =
                                                      name;
                                                  bool found = false;
                                                  for (var i = 0;
                                                      i <
                                                              adminController
                                                                  .compList
                                                                  .length &&
                                                          !found;
                                                      i++) {
                                                    for (var j = 0;
                                                        j <
                                                                (adminController
                                                                        .compList[
                                                                            i]
                                                                        .levels
                                                                        ?.length ??
                                                                    0) &&
                                                            !found;
                                                        j++) {
                                                      for (var k = 0;
                                                          k <
                                                                  (adminController
                                                                          .compList[
                                                                              i]
                                                                          .levels?[
                                                                              j]
                                                                          .skills
                                                                          ?.length ??
                                                                      1) &&
                                                              !found;
                                                          k++) {
                                                        found = true;
                                                        adminController
                                                            .compList[i]
                                                            .levels?[j]
                                                            .skills?[k]
                                                            .skillName = name;
                                                      }
                                                    }
                                                  }
                                                });
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
                                  visible: index < skills.length - 1,
                                  child: const Divider(
                                    thickness: 0.0,
                                    height: 19,
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
                    //add skill
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AElevatedButtonExtended(
                  text: 'Изменить тест',
                  textSize: 30,
                  width: w * 0.98,
                  pad: false,
                  onPressed: () async {
                    // Navigator.pop(context);
                    if (widget.level.tests.isNotEmpty) {
                      Get.to(() => TestPage(
                          test: widget.level.tests[0],
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
