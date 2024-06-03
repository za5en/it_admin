import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_admin/view/pages/users/user_comps.dart';

import '../../../controllers/admin_controller.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_svg_icon.dart';
import '../login.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var page = 1;
  var adminController = Get.find<AdminController>();
  var pageList = [];
  bool filter = false;
  var search = '';
  @override
  Widget build(BuildContext context) {
    int pages = adminController.userList.length ~/ 10 + 1;
    if (!filter) {
      pageList = adminController.userList.length < 10 * page
          ? adminController.userList
              .getRange(10 * (page - 1), adminController.userList.length)
              .toList()
          : adminController.userList
              .getRange(10 * (page - 1), 10 * page)
              .toList();
    }

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
                      child: Container(
                        padding: EdgeInsets.only(left: w * 0.007),
                        margin: EdgeInsets.symmetric(vertical: w * 0.008),
                        width: 400,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              search = val;
                            });
                          },
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 20),
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'Имя пользователя',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                child: Image.asset(
                                  'assets/images/search.png',
                                  height: 15.0,
                                ),
                                onTap: () {
                                  // var userList = adminController.getUsers();
                                  setState(() {
                                    if (search != '') {
                                      setState(() {
                                        pageList = adminController
                                                    .userList.length <
                                                10 * page
                                            ? adminController.userList
                                                .getRange(
                                                    10 * (page - 1),
                                                    adminController
                                                        .userList.length)
                                                .toList()
                                            : adminController.userList
                                                .getRange(
                                                    10 * (page - 1), 10 * page)
                                                .toList();
                                        pageList = pageList
                                            .where((element) => element.name
                                                .toString()
                                                .toLowerCase()
                                                .contains(search.toLowerCase()))
                                            .toList();
                                        filter = true;
                                      });
                                    } else {
                                      setState(() {
                                        pageList = adminController
                                                    .userList.length <
                                                10 * page
                                            ? adminController.userList
                                                .getRange(
                                                    10 * (page - 1),
                                                    adminController
                                                        .userList.length)
                                                .toList()
                                            : adminController.userList
                                                .getRange(
                                                    10 * (page - 1), 10 * page)
                                                .toList();
                                        filter = false;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
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
                                                    pageList[index].name ??
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
                                              Get.to(() => UserComps(
                                                  user: pageList[index]));
                                            },
                                          ),
                                          InkWell(
                                            child: Text(
                                              pageList[index].email ?? 'email',
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
                                                      text: pageList[index]
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
                                            onTap: () async {
                                              var name = await editDialog(
                                                  context,
                                                  'Изменить имя пользователя ${pageList[index].name}:');
                                              if (name != null) {
                                                var id = pageList[index].id;
                                                setState(() {
                                                  pageList[index].name = name !=
                                                          ''
                                                      ? name
                                                      : pageList[index].name;
                                                });
                                                for (var i = 0;
                                                    i <
                                                        adminController
                                                            .userList.length;
                                                    i++) {
                                                  if (adminController
                                                          .userList[i].id ==
                                                      id) {
                                                    setState(() {
                                                      adminController
                                                              .userList[i]
                                                              .name =
                                                          name != ''
                                                              ? name
                                                              : adminController
                                                                  .userList[i]
                                                                  .name;
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                          // const SizedBox(
                                          //   width: 30.0,
                                          // ),
                                          // InkWell(
                                          //   child: Image.asset(
                                          //     'assets/images/report.png',
                                          //     color: Theme.of(context)
                                          //         .colorScheme
                                          //         .primary,
                                          //     height: 45,
                                          //   ),
                                          //   onTap: () {
                                          //     alertDialog(context,
                                          //         'Составить отчёт по пользователю ${pageList[index].name} и скачать его?',
                                          //         () {
                                          //       Navigator.pop(context);
                                          //     });
                                          //   },
                                          // ),
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
                            search = '';
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
                              search = '';
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
                              search = '';
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
                            search = '';
                          });
                        },
                      ),
                    ),
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
    var newUserName = await showDialog(
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
                        text: 'Имя пользователя',
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
    return newUserName;
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
