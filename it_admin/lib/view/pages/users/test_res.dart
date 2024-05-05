import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/test.dart';
import '../../widgets/a_app_bar.dart';

class TestRes extends StatefulWidget {
  const TestRes({super.key, required this.userName, required this.test});
  final String userName;
  final UserTest test;

  @override
  State<TestRes> createState() => _TestResState();
}

class _TestResState extends State<TestRes> {
  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    var len = widget.test.testQs?.length ?? 0;
    var ansLen = widget.test.userAns?.length ?? 0;
    var rights = 0;
    var wrongs = 0;

    for (var i = 0; i < ansLen; i++) {
      if (widget.test.userAns?[i] == widget.test.testCorr?[i]) {
        rights++;
      } else {
        wrongs++;
      }
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
            Get.until((route) => Get.currentRoute == '/users');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: w * 0.008),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(widget.userName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 35, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'тест: ${widget.test.testTimeStart}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Время прохождения теста: 0:${widget.test.solutionDuration}:00',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Количество вопросов: $len',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Дано ответов: ${widget.test.userAns?.length ?? 0}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 30),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Правильных',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 30,
                                    color:
                                        const Color.fromRGBO(0, 114, 11, 1.0))),
                        TextSpan(text: ': $rights\t'),
                        TextSpan(
                            text: 'Неправильных',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 30,
                                    color: const Color.fromRGBO(
                                        195, 59, 59, 1.0))),
                        TextSpan(text: ': $wrongs'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 35.0),
                  child: Container(
                    height: len * 60,
                    width: w * 0.98,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListView.builder(
                            itemCount: len,
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
                                                    top: 5.0,
                                                    left: 30.0,
                                                    right: 30.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            fontSize: 30),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${index + 1}: '),
                                                      TextSpan(
                                                          text:
                                                              '${widget.test.userAns?[index] ?? 1}',
                                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                              fontSize: 30,
                                                              color: widget.test
                                                                              .userAns?[
                                                                          index] ==
                                                                      widget.test
                                                                              .testCorr?[
                                                                          index]
                                                                  ? const Color
                                                                          .fromRGBO(
                                                                      0,
                                                                      114,
                                                                      11,
                                                                      1.0)
                                                                  : const Color
                                                                          .fromRGBO(
                                                                      195,
                                                                      59,
                                                                      59,
                                                                      1.0))),
                                                      TextSpan(
                                                          text:
                                                              ' (правильно - ${widget.test.testCorr?[index] ?? 1})'),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              onTap: () {
                                                alertDialog(context,
                                                    'Выбран ответ:\n${widget.test.userAns?[index] ?? 1}. ${widget.test.testAns?[index][widget.test.userAns?[index] ?? 1] ?? 'abcabc'}\nПравильный ответ:\n${widget.test.testCorr?[index] ?? 1}. ${widget.test.testAns?[index][widget.test.testCorr?[index] ?? 1] ?? 'bacbac'}');
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: index < len - 1,
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
                  padding: EdgeInsets.only(bottom: h * 0.01),
                  child: Text(
                    'система администрирования сервиса развития навыков сотрудников IT компаний, 2024',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertDialog(context, message) {
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
                            ?.copyWith(fontSize: 30),
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
                  getButton('Ок', () {
                    Navigator.pop(context);
                  }),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
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
