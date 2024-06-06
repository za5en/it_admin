import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_admin/data/competency.dart';
import 'package:it_admin/view/pages/comps/skills.dart';

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
import 'create_comp.dart';

class Comps extends StatefulWidget {
  const Comps({super.key});

  @override
  State<Comps> createState() => _CompsState();
}

class _CompsState extends State<Comps> {
  var name = 'Название компетенции';
  var page = 1;
  var adminController = Get.find<AdminController>();
  List<Competency> pageList = [];
  bool filter = false;
  List<int> priority = [-1, 1, 2, 3, 4, 5];
  List<int> levelVisibility = [];

  @override
  Widget build(BuildContext context) {
    int levelsLength = 0;
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

    for (var i = 0; i < levelVisibility.length; i++) {
      levelsLength += ((pageList[levelVisibility[i]].levels?.length ?? 1) != 0)
          ? (pageList[levelVisibility[i]].levels?.length ?? 1) + 1
          : 1;
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
                  height: pageList.length < 10
                      ? pageList.length * 66 + levelsLength * 60.5
                      : levelsLength * 60.5 + 660,
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
                                                pageList[index].name ??
                                                    'competency',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 30),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (levelVisibility
                                                    .contains(index)) {
                                                  levelVisibility.remove(index);
                                                } else {
                                                  levelVisibility.add(index);
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
                                                  'Введите название компетенции:',
                                                  false);
                                              if (name != null) {
                                                var id = pageList[index].id;
                                                // setState(() {
                                                //   pageList[index].name = name !=
                                                //           ''
                                                //       ? name
                                                //       : pageList[index].name;
                                                // });
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
                                                      id) {
                                                    setState(() {
                                                      find = true;
                                                      adminController
                                                              .compList[i]
                                                              .name =
                                                          name != ''
                                                              ? name
                                                              : adminController
                                                                  .compList[i]
                                                                  .name;
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       right: 5.0),
                                          //   child: InkWell(
                                          //     child: Image.asset(
                                          //       'assets/images/bin.png',
                                          //       color: Theme.of(context)
                                          //           .colorScheme
                                          //           .primary,
                                          //       height: 35,
                                          //     ),
                                          //     onTap: () {
                                          //       alertDialog(context,
                                          //           'Удалить компетенцию?', () {
                                          //         setState(() {
                                          //           adminController.compList
                                          //               .remove(
                                          //                   pageList[index]);
                                          //         });
                                          //         Navigator.pop(context);
                                          //       });
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: levelVisibility.contains(index),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Divider(
                                      thickness: 0.0,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: levelVisibility.contains(index) &&
                                      (pageList[index].levels?.isNotEmpty ??
                                          false),
                                  child: SizedBox(
                                    height:
                                        (pageList[index].levels?.length ?? 0) *
                                            61,
                                    child: ListView.builder(
                                      itemCount:
                                          (pageList[index].levels?.length ?? 0),
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
                                                                  pageList[index]
                                                                          .levels?[
                                                                              j]
                                                                          .levelName ??
                                                                      'level',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              30),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                Get.to(() => Skills(
                                                                    compId: pageList[index].id,
                                                                    level: pageList[index].levels?[j] ??
                                                                        Level(
                                                                            id: 1,
                                                                            skills: [
                                                                              Skill(id: 1, skillName: 'навык', fileInfo: [
                                                                                'filename.md'
                                                                              ])
                                                                            ],
                                                                            levelName: 'уровень',
                                                                            priority: 1,
                                                                            tests: [])));
                                                              },
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
                                                                var levelInfo = await levelDialog(
                                                                    context,
                                                                    'Уровень:',
                                                                    pageList[index]
                                                                            .levels?[j]
                                                                            .priority ??
                                                                        1,
                                                                    false);
                                                                if (levelInfo !=
                                                                        null &&
                                                                    levelInfo
                                                                        .isNotEmpty &&
                                                                    (levelInfo[0] !=
                                                                            '' ||
                                                                        levelInfo[1] !=
                                                                            '-1')) {
                                                                  var id = pageList[
                                                                          index]
                                                                      .id;
                                                                  var levelId =
                                                                      pageList[
                                                                              index]
                                                                          .levels?[
                                                                              j]
                                                                          .id;
                                                                  // setState(() {
                                                                  //   if (levelInfo[
                                                                  //           0] !=
                                                                  //       '') {
                                                                  //     pageList[
                                                                  //             index]
                                                                  //         .levels?[
                                                                  //             j]
                                                                  //         .levelName = levelInfo[0] !=
                                                                  //             ''
                                                                  //         ? levelInfo[
                                                                  //             0]
                                                                  //         : pageList[index]
                                                                  //             .levels?[j]
                                                                  //             .levelName;
                                                                  //   }
                                                                  //   if (levelInfo[
                                                                  //           1] !=
                                                                  //       '-1') {
                                                                  //     pageList[
                                                                  //             index]
                                                                  //         .levels?[
                                                                  //             j]
                                                                  //         .priority = levelInfo[1] !=
                                                                  //             '-1'
                                                                  //         ? int.tryParse(levelInfo[
                                                                  //             1])
                                                                  //         : pageList[index]
                                                                  //             .levels?[j]
                                                                  //             .priority;
                                                                  //   }
                                                                  // });
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
                                                                        id) {
                                                                      for (var k =
                                                                              0;
                                                                          k < (adminController.compList[i].levels?.length ?? 0) &&
                                                                              !find;
                                                                          k++) {
                                                                        if (adminController.compList[i].levels?[k].id ==
                                                                            levelId) {
                                                                          setState(
                                                                              () {
                                                                            find =
                                                                                true;
                                                                            if (levelInfo[0] !=
                                                                                '') {
                                                                              adminController.compList[i].levels?[k].levelName = levelInfo[0] != '' ? levelInfo[0] : adminController.compList[i].levels?[k].levelName;
                                                                            }
                                                                            if (levelInfo[1] !=
                                                                                '-1') {
                                                                              adminController.compList[i].levels?[k].priority = levelInfo[1] != '-1' ? int.tryParse(levelInfo[1]) : adminController.compList[i].levels?[k].priority;
                                                                            }
                                                                          });
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
                                                                      'Удалить уровень?',
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      adminController
                                                                          .compList[
                                                                              index]
                                                                          .levels
                                                                          ?.remove(
                                                                              pageList[index].levels?[j]);
                                                                    });
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
                                  visible: levelVisibility.contains(index),
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
                                                  'Добавить новый уровень',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(fontSize: 30),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            var levelInfo = await levelDialog(
                                                context, 'Уровень:', -1, true);
                                            if (levelInfo != null &&
                                                levelInfo.isNotEmpty &&
                                                levelInfo[0] != '' &&
                                                levelInfo[1] != '-1') {
                                              var level = Level(
                                                  id: pageList[index]
                                                              .levels
                                                              ?.isNotEmpty ??
                                                          false
                                                      ? pageList[index]
                                                              .levels!
                                                              .last
                                                              .id +
                                                          1
                                                      : 1,
                                                  levelName: levelInfo[0],
                                                  skills: [],
                                                  priority:
                                                      int.parse(levelInfo[1]),
                                                  tests: []);
                                              // setState(() {
                                              //   pageList[index]
                                              //       .levels
                                              //       ?.add(level);
                                              // });
                                              bool find = false;
                                              var id = pageList[index].id;
                                              for (var i = 0;
                                                  i <
                                                          adminController
                                                              .compList
                                                              .length &&
                                                      !find;
                                                  i++) {
                                                if (adminController
                                                        .compList[i].id ==
                                                    id) {
                                                  setState(() {
                                                    find = true;
                                                    pageList[index]
                                                        .levels
                                                        ?.add(level);
                                                  });
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
                                  visible: index < pageList.length - 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: levelVisibility.contains(index)
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
                  setState(() {});
                  if (name != null) {
                    var newComp = Competency(
                        id: adminController.compList.isNotEmpty
                            ? adminController.compList.last.id + 1
                            : 1,
                        levels: [
                          Level(
                            id: 1,
                            skills: [
                              Skill(
                                  id: 1,
                                  skillName: 'skill1',
                                  fileInfo: ['filename.md'])
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
                                  1: [
                                    'Ответ 1',
                                    'Ответ 2',
                                    'Ответ 3',
                                    'Ответ 4'
                                  ],
                                  2: [
                                    'Ответ 1',
                                    'Ответ 2',
                                    'Ответ 3',
                                    'Ответ 4'
                                  ],
                                  3: [
                                    'Ответ 1',
                                    'Ответ 2',
                                    'Ответ 3',
                                    'Ответ 4'
                                  ],
                                  4: [
                                    'Ответ 1',
                                    'Ответ 2',
                                    'Ответ 3',
                                    'Ответ 4'
                                  ]
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
                  }
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

  Future<String?> editDialog(context, message, create) async {
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
                          onTap: () async {
                            await Get.to(() => const CreateComp());
                            setState(() {});
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
                    Navigator.pop(context, newName);
                  }),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
    return newCompName;
  }

  Future<List<String>?> levelDialog(
      context, message, levelPriority, create) async {
    List<String>? newData;
    var newLevelData = await showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            title: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.01,
                ),
                child: SizedBox(
                  height: 200,
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
                        onChanged: (p0) => (newData?.isEmpty ?? true)
                            ? newData = [p0, levelPriority.toString()]
                            : newData?[0] = p0,
                        enabled: true,
                      ),
                      ParamWithDropDown(
                        popupSize: MediaQuery.of(context).size.width * 0.1,
                        popupMenuButton: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    levelPriority == -1
                                        ? 'Приоритет'
                                        : levelPriority.toString(),
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
                          setState(() {
                            levelPriority = priority[value];
                            if (newData != null && newData!.isNotEmpty) {
                              newData?[1] = priority[value].toString();
                            } else {
                              newData = ['', priority[value].toString()];
                            }
                          });
                        },
                        popupMenuData: [
                          for (var i = 0; i < priority.length; i++)
                            APopupMenuData(
                              child: Text(
                                  i == 0 ? 'Приоритет' : priority[i].toString(),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                        ],
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
                    if (create) {
                      if ((newData?.isNotEmpty ?? false) &&
                          newData?[0] != '' &&
                          newData?[1] != '' &&
                          newData?[1] != '-1') {
                        Navigator.pop(context, newData);
                      } else {
                        Get.snackbar('Ошибка', 'Необходимо заполнить все поля');
                      }
                    } else {
                      Navigator.pop(context, newData);
                    }
                  }),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        },
      ),
    );
    return newLevelData;
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
