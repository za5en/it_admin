import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../widgets/a_app_bar.dart';
import '../../widgets/a_drop_down.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_pop_up.dart';
import '../../widgets/a_svg_icon.dart';

class Comps extends StatefulWidget {
  const Comps({super.key});

  @override
  State<Comps> createState() => _CompsState();
}

class _CompsState extends State<Comps> {
  var name = 'Название компетенции';
  @override
  Widget build(BuildContext context) {
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
              alertDialog(context, 'Выйти из аккаунта?', false, () async {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
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
                              BorderRadius.all(Radius.circular(w * 0.032)),
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
                        var compList = [
                          'Название компетенции',
                          'competency1',
                          'competency2',
                          'competency3',
                          'competency4',
                          'competency5',
                          'competency6'
                        ];
                        setState(() {
                          name = compList[value];
                        });
                      },
                      popupMenuData: [
                        APopupMenuData(
                          child: Text('Название компетенции',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency1',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency2',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency3',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency4',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency5',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        APopupMenuData(
                          child: Text('competency6',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(w * 0.021),
                      child: Text(
                        'Авторизация',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
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
    );
  }

  alertDialog(context, message, isEdit, onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            title: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Column(
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
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.01)),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getButton(isEdit ? 'Отмена' : 'Нет', () {
                    Navigator.pop(context);
                  }),
                  getButton(isEdit ? 'Ок' : 'Да', onPressed),
                ]),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

  Widget getButton(String text, Function() onPressed) => Container(
        height: MediaQuery.of(context).size.height * 0.055,
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
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
        ),
      );
}
