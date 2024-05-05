import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/data/test.dart';
import 'package:it_admin/view/pages/users/test_res.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/user.dart';
import '../../widgets/a_app_bar.dart';

class UserTests extends StatefulWidget {
  const UserTests({super.key, required this.userName, required this.comp});
  final String userName;
  final UserCompetency comp;

  @override
  State<UserTests> createState() => _UserTestsState();
}

class _UserTestsState extends State<UserTests> {
  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    var len = widget.comp.tests?.length ?? 0;

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
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Text(
                    'История прохождения тестов по ${widget.comp.name}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Text(
                    'Количество попыток: $len',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
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
                                                    top: 2.5,
                                                    left: 30.0,
                                                    right: 30.0),
                                                child: Text(
                                                  'тест: ${widget.comp.tests?[index].testTimeStart.toString() ?? DateTime.now().toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(fontSize: 30),
                                                ),
                                              ),
                                              onTap: () {
                                                Get.to(() => TestRes(
                                                    userName: widget.userName,
                                                    test: widget.comp
                                                            .tests?[index] ??
                                                        UserTest(
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
                                                          testCorr: [
                                                            2,
                                                            3,
                                                            1,
                                                            2
                                                          ],
                                                          userAns: [2, 3, 1, 1],
                                                          testTime: 15,
                                                          testTimeStart:
                                                              DateTime.now(),
                                                          solutionDuration: 12,
                                                        )));
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
}
