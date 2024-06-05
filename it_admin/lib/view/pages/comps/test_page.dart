import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/data/test.dart';

import '../../../controllers/admin_controller.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_elevated_button.dart';
import '../login.dart';

class TestPage extends StatefulWidget {
  const TestPage(
      {super.key,
      required this.test,
      required this.levelName,
      required this.create,
      this.compId,
      this.levelId});

  final Test test;
  final String levelName;
  final bool create;
  final int? compId;
  final int? levelId;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    var questionList = widget.test.testQs ?? [];
    var answerList = widget.test.testAns ?? {};
    var correctList = widget.test.testCorr ?? [];
    var testTime = widget.test.testTime ?? 10;
    var answerKeys = answerList.keys.toList();

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
                        child: Text('${widget.levelName} тест',
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
                                if (questionList.isNotEmpty) {
                                  alertDialog(context, 'Сохранить и выйти?',
                                      () {
                                    if (widget.create) {
                                      adminController.setTest(1, questionList,
                                          answerList, correctList, testTime);
                                    } else {
                                      bool find = false;
                                      for (var i = 0;
                                          i < adminController.compList.length &&
                                              !find;
                                          i++) {
                                        if (adminController.compList[i].id ==
                                            widget.compId) {
                                          for (var j = 0;
                                              j <
                                                      (adminController
                                                              .compList[i]
                                                              .levels
                                                              ?.length ??
                                                          0) &&
                                                  !find;
                                              j++) {
                                            if (adminController.compList[i]
                                                    .levels?[j].id ==
                                                widget.levelId) {
                                              if (adminController
                                                      .compList[i]
                                                      .levels?[j]
                                                      .tests
                                                      .isNotEmpty ??
                                                  false) {
                                                adminController.compList[i]
                                                        .levels?[j].tests[0] =
                                                    (Test(
                                                        id: adminController
                                                                .compList[i]
                                                                .levels?[j]
                                                                .tests[0]
                                                                .id ??
                                                            1,
                                                        testQs: questionList,
                                                        testAns: answerList,
                                                        testCorr: correctList,
                                                        testTime: testTime));
                                              } else {
                                                adminController.compList[i]
                                                    .levels?[j].tests
                                                    .add(Test(
                                                        id: 1,
                                                        testQs: questionList,
                                                        testAns: answerList,
                                                        testCorr: correctList,
                                                        testTime: testTime));
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }, false);
                                } else {
                                  alertDialog(
                                      context,
                                      'Нужно добавить хотя бы один вопрос и заполнить поля',
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
                    Text(
                      'Время прохождения теста (минут):',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: LoginTextField(
                        text: testTime.toString(),
                        onChanged: (p0) => testTime = int.parse(p0),
                        enabled: true,
                        width: w * 0.05,
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
                  visible: questionList.isNotEmpty,
                  child: SizedBox(
                    height: questionList.length * 220,
                    child: ListView.builder(
                      itemCount: questionList.length,
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
                                      LoginTextField(
                                        width: w * 0.906,
                                        text: questionList[index] == ''
                                            ? 'Вопрос'
                                            : questionList[index],
                                        onChanged: (p0) =>
                                            questionList[index] = p0,
                                        enabled: true,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Это поле должно быть заполнено';
                                          }
                                          return null;
                                        },
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
                                                context, 'Удалить вопрос?', () {
                                              setState(() {
                                                questionList.removeAt(index);
                                                answerList
                                                    .remove(answerKeys[index]);
                                                answerKeys.remove(index);
                                                correctList.removeAt(index);
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
                                  padding: EdgeInsets.only(
                                      left: w * 0.01,
                                      right: w * 0.01,
                                      bottom: h * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.445,
                                            padding: EdgeInsets.only(
                                                left: w * 0.007),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  answerList[answerKeys[index]]
                                                      [0] = val;
                                                });
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(fontSize: 20),
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: answerList[answerKeys[
                                                            index]][0] ==
                                                        ''
                                                    ? 'Ответ 1'
                                                    : answerList[
                                                        answerKeys[index]][0],
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 20),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: w * 0.01),
                                            child: Transform.scale(
                                              scale: 1.25,
                                              child: Checkbox(
                                                value: correctList[index] == 1,
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                checkColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    correctList[index] = 1;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.435,
                                            padding: EdgeInsets.only(
                                                left: w * 0.007),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  answerList[answerKeys[index]]
                                                      [1] = val;
                                                });
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(fontSize: 20),
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: answerList[answerKeys[
                                                            index]][1] ==
                                                        ''
                                                    ? 'Ответ 2'
                                                    : answerList[
                                                        answerKeys[index]][1],
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 20),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: Transform.scale(
                                              scale: 1.25,
                                              child: Checkbox(
                                                value: correctList[index] == 2,
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                checkColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    correctList[index] = 2;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: w * 0.01,
                                      right: w * 0.01,
                                      bottom: h * 0.015),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.445,
                                            padding: EdgeInsets.only(
                                                left: w * 0.007),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  answerList[answerKeys[index]]
                                                      [2] = val;
                                                });
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(fontSize: 20),
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: answerList[answerKeys[
                                                            index]][2] ==
                                                        ''
                                                    ? 'Ответ 3'
                                                    : answerList[
                                                        answerKeys[index]][2],
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 20),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: w * 0.01),
                                            child: Transform.scale(
                                              scale: 1.25,
                                              child: Checkbox(
                                                value: correctList[index] == 3,
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                checkColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    correctList[index] = 3;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.435,
                                            padding: EdgeInsets.only(
                                                left: w * 0.007),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  answerList[answerKeys[index]]
                                                      [3] = val;
                                                });
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(fontSize: 20),
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: answerList[answerKeys[
                                                            index]][3] ==
                                                        ''
                                                    ? 'Ответ 4'
                                                    : answerList[
                                                        answerKeys[index]][3],
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 20),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: Transform.scale(
                                              scale: 1.25,
                                              child: Checkbox(
                                                value: correctList[index] == 4,
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                checkColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    correctList[index] = 4;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                text: 'Добавить вопрос',
                textSize: 30,
                width: w * 0.98,
                pad: false,
                onPressed: () async {
                  setState(() {
                    questionList.add('');
                    answerList.addAll({
                      questionList.length: ['', '', '', '']
                    });
                    answerKeys.add(questionList.length);
                    correctList.add(-1);
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
