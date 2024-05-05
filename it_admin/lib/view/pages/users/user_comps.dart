import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/view/pages/users/user_tests.dart';

import '../../../controllers/admin_controller.dart';
import '../../../data/user.dart';
import '../../widgets/a_app_bar.dart';
import '../../widgets/a_drop_down.dart';
import '../../widgets/a_elevated_button.dart';
import '../../widgets/a_pop_up.dart';
import '../../widgets/a_svg_icon.dart';

class UserComps extends StatefulWidget {
  const UserComps({super.key, required this.user});
  final User user;

  @override
  State<UserComps> createState() => _UserCompsState();
}

class _UserCompsState extends State<UserComps> {
  var name = 'Название компетенции';
  var page = 1;
  var adminController = Get.find<AdminController>();
  var pageList = [];
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    int len = widget.user.comps?.length ?? 1;
    int pages = len ~/ 10 + 1;
    if (!filter) {
      pageList = len < 10 * page
          ? widget.user.comps?.getRange(10 * (page - 1), len).toList() ?? []
          : widget.user.comps?.getRange(10 * (page - 1), 10 * page).toList() ??
              [];
    }

    var compList = ['Название компетенции'];
    List<String> compNames = [];
    for (var i = 0; i < len; i++) {
      compNames.add(widget.user.comps?[i].name ?? 'competency');
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            .getRange(
                                                10 * (page - 1), 10 * page)
                                            .toList();
                                    pageList = pageList
                                        .where(
                                            (element) => element.name == name)
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
                                            .getRange(
                                                10 * (page - 1), 10 * page)
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.user.name ?? 'user',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 35, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.008, top: 15),
                        child: const SizedBox(
                          width: 400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  'Компетенции пользователя',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 35.0),
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
                                                pageList[index].name ??
                                                    'competency',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(fontSize: 30),
                                              ),
                                            ),
                                            onTap: () {
                                              Get.to(() => UserTests(
                                                  userName: widget.user.name ??
                                                      'user',
                                                  comp: pageList[index]));
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: widget.user.comps?[index]
                                                    .isCompleted ??
                                                false,
                                            child: Image.asset(
                                              'assets/images/tick.png',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              height: 45,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30.0,
                                          ),
                                          InkWell(
                                            child: Image.asset(
                                              'assets/images/testing.png',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              height: 45,
                                            ),
                                            onTap: () {
                                              Get.to(() => UserTests(
                                                  userName: widget.user.name ??
                                                      'user',
                                                  comp: pageList[index]));
                                            },
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
}
