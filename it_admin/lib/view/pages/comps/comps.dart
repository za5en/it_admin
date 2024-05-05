import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_admin/data/competency.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/level.dart';
import '../../../data/skill.dart';
import '../../../data/test.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_drop_down.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_pop_up.dart';
import '../../widgets/a_svg_icon.dart';
import '../login.dart';

class Comps extends StatefulWidget {
  const Comps({super.key});

  @override
  State<Comps> createState() => _CompsState();
}

class _CompsState extends State<Comps> {
  var name = 'Название компетенции';
  var page = 1;
  var adminController = Get.find<AdminController>();
  var pageList = [];
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    int pages = adminController.compList.length ~/ 10 + 1;
    if (!filter) {
      pageList = adminController.compList.length < 10 * page
          ? adminController.compList
              .getRange(10 * (page - 1), adminController.compList.length)
              .toList()
          : adminController.compList
              .getRange(10 * (page - 1), 10 * page)
              .toList();
    }

    var compList = ['Название компетенции'];
    List<String> compNames = [];
    for (var i = 0; i < adminController.compList.length; i++) {
      compNames.add(adminController.compList[i].name ?? 'competency');
    }
    compNames = compNames.toSet().toList();
    compList.addAll(compNames);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AAppBar(
        nonDefWidth: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text('Компетенции',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 35, fontWeight: FontWeight.w600)),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
          child: AElevatedButtonExtended(
            text: 'Пользователи',
            textSize: 20,
            width: 200,
            pad: false,
            onPressed: () async {
              Get.offNamed('/users');
            },
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(right: w * 0.011, bottom: h * 0.001),
              child: Center(
                child: Image.asset(
                  'assets/images/exit.png',
                  color: Theme.of(context).colorScheme.primary,
                  height: 30,
                ),
              ),
            ),
            onTap: () {
              alertDialog(context, 'Выйти из аккаунта?', () async {
                await Hive.box('user').put('isLogged', false);
                await Hive.box('settings').put('initial_screen', '/');
                Get.back();
                Get.offAllNamed('/');
              });
            },
          ),
        ],
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
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.008, top: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ParamWithDropDown(
                        popupSize: MediaQuery.of(context).size.width * 0.1,
                        popupMenuButton: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: ASvgIcon(
                                  assetName: 'assets/images/triangle.svg',
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
                          // var compList = adminController.getComps();
                          setState(() {
                            name = compList[value];
                            if (name != 'Название компетенции') {
                              setState(() {
                                pageList = adminController.compList.length <
                                        10 * page
                                    ? adminController.compList
                                        .getRange(10 * (page - 1),
                                            adminController.compList.length)
                                        .toList()
                                    : adminController.compList
                                        .getRange(10 * (page - 1), 10 * page)
                                        .toList();
                                pageList = pageList
                                    .where((element) => element.name == name)
                                    .toList();
                                filter = true;
                              });
                            } else {
                              setState(() {
                                pageList = adminController.compList.length <
                                        10 * page
                                    ? adminController.compList
                                        .getRange(10 * (page - 1),
                                            adminController.compList.length)
                                        .toList()
                                    : adminController.compList
                                        .getRange(10 * (page - 1), 10 * page)
                                        .toList();
                                filter = false;
                              });
                            }
                          });
                        },
                        popupMenuData: [
                          for (var i = 0; i < compList.length; i++)
                            APopupMenuData(
                              child: Text(compList[i],
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Container(
                  height: pageList.length < 10 ? pageList.length * 65 : 650,
                  width: w * 0.98,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          itemCount: pageList.length,
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
                                                pageList[index].name ?? 'user',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 30),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                //unhide levels (bool)
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
                                                  'Введите название компетенции:',
                                                  false);
                                              var id = pageList[index].id;
                                              setState(() {
                                                pageList[index].name =
                                                    name != ''
                                                        ? name
                                                        : pageList[index].name;
                                              });
                                              for (var i = 0;
                                                  i <
                                                      adminController
                                                          .compList.length;
                                                  i++) {
                                                if (adminController
                                                        .compList[i].id ==
                                                    id) {
                                                  setState(() {
                                                    adminController
                                                            .compList[i].name =
                                                        name != ''
                                                            ? name
                                                            : adminController
                                                                .compList[i]
                                                                .name;
                                                  });
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
                                                alertDialog(context,
                                                    'Удалить компетенцию?', () {
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
                                  visible: index < pageList.length - 1,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: page != 1,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            '1',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            page = 1;
                            filter = false;
                            name = 'Название компетенции';
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: pages > 5 && page > 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '...',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                    for (var i = page - 2 > 1
                            ? page - 2
                            : page - 1 > 1
                                ? page - 1
                                : page;
                        i < page;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          child: Text(
                            i.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                          onTap: () {
                            setState(() {
                              page = i;
                              filter = false;
                              name = 'Название компетенции';
                            });
                          },
                        ),
                      ),
                    AElevatedButtonExtended(
                        width: 50,
                        pad: false,
                        textSize: 20,
                        text: page.toString(),
                        onPressed: () {}),
                    for (var i = page + 1;
                        page + 2 < pages
                            ? i <= page + 2
                            : page + 2 == pages
                                ? i <= page + 1
                                : i < page + 1;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          child: Text(
                            i.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                          onTap: () {
                            setState(() {
                              page = i;
                              filter = false;
                              name = 'Название компетенции';
                            });
                          },
                        ),
                      ),
                    Visibility(
                      visible: pages > 5 && page <= pages - 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '...',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: page != pages && pages > page,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            pages.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            page = pages;
                            filter = false;
                            name = 'Название компетенции';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AElevatedButtonExtended(
                text: 'Создать новую компетенцию',
                textSize: 30,
                width: w * 0.98,
                pad: false,
                onPressed: () async {
                  var name = await editDialog(
                      context, 'Введите название компетенции:', true);
                  var newComp = Competency(
                      id: adminController.compList.last.id + 1,
                      levels: [
                        Level(
                          id: adminController.compList.last.id + 1,
                          skills: [
                            Skill(
                                id: adminController.compList.last.id + 1,
                                skillName: 'skill1',
                                fileInfo: {1: 'filename.md'})
                          ],
                          levelName: 'level1',
                          priority: 1,
                          tests: [
                            Test(
                              id: 1,
                              testQs: [
                                'Вопрос 1',
                                'Вопрос 2',
                                'Вопрос 3',
                                'Вопрос 4'
                              ],
                              testAns: {
                                1: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                                2: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                                3: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4'],
                                4: ['Ответ 1', 'Ответ 2', 'Ответ 3', 'Ответ 4']
                              },
                              testCorr: [2, 3, 1, 2],
                              testTime: 15,
                            )
                          ],
                        )
                      ],
                      name: name);
                  setState(() {
                    if (page == pages && pageList.length < 10) {
                      pageList.add(newComp);
                    }
                    adminController.compList.add(newComp);
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

  Future<String> editDialog(context, message, create) async {
    var newCompName = await showDialog(
        context: context,
        builder: (BuildContext context) {
          String newName = '';
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
                      Visibility(
                        visible: create,
                        child: InkWell(
                          child: Text(
                            'Перейти к экрану создания компетенции',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Get.to(() => CreateComp());
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
                    Navigator.pop(context, '');
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
