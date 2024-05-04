import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../controllers/admin_controller.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_drop_down.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_pop_up.dart';
import '../../widgets/a_svg_icon.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var name = 'Имя пользователя';
  var page = 1;
  var adminController = Get.find<AdminController>();
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
          child: Text('Пользователи',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 35, fontWeight: FontWeight.w600)),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.008, top: 10.0),
          child: AElevatedButtonExtended(
            text: 'Компетенции',
            textSize: 20,
            width: 200,
            pad: false,
            onPressed: () async {
              Get.offNamed('/comps');
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
                          // var userList = adminController.getUsers();
                          var userList = [
                            'Имя пользователя',
                            'userName1',
                            'userName2',
                            'userName3',
                            'userName4',
                            'userName5',
                            'userName6'
                          ];
                          setState(() {
                            name = userList[value];
                          });
                        },
                        popupMenuData: [
                          APopupMenuData(
                            child: Text('Имя пользователя',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName1',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName2',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName3',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName4',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName5',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          APopupMenuData(
                            child: Text('userName6',
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
                  height: adminController.userList.length < 10
                      ? adminController.userList.length * 65
                      : h,
                  width: w * 0.98,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          itemCount: adminController.userList.length < 10
                              ? adminController.userList.length
                              : 10,
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
                                            child: Row(
                                              children: [
                                                const ASvgIcon(
                                                  assetName:
                                                      'assets/images/avatar.svg',
                                                  height: 45,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30.0,
                                                          right: 30.0),
                                                  child: Text(
                                                    adminController
                                                            .userList[index]
                                                            .name ??
                                                        'user',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            fontSize: 30),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              //open user_comps page
                                            },
                                          ),
                                          InkWell(
                                            child: Text(
                                              adminController
                                                      .userList[index].email ??
                                                  'email',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      fontSize: 30,
                                                      decoration: TextDecoration
                                                          .underline),
                                            ),
                                            onTap: () async {
                                              await Clipboard.setData(
                                                  ClipboardData(
                                                      text: adminController
                                                              .userList[index]
                                                              .email ??
                                                          'email'));
                                              Get.snackbar('Успешно',
                                                  'Email скопирован в буфер обмена');
                                            },
                                          )
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
                                            onTap: () {},
                                          ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                          InkWell(
                                            child: Image.asset(
                                              'assets/images/report.png',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              height: 45,
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: adminController.userList.length < 10
                                      ? index <
                                          adminController.userList.length - 1
                                      : index < 9,
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
                    AElevatedButtonExtended(
                        width: 50,
                        pad: false,
                        textSize: 20,
                        text: page.toString(),
                        onPressed: () {}),
                  ],
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
