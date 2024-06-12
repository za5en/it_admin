import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_admin/controllers/admin_controller.dart';
import 'package:it_admin/view/pages/keycloak_login.dart';
// import 'package:it_admin/view/pages/login.dart';

import '../widgets/a_elevated_button.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: h * 0.1,
                  left: w * 0.133,
                  right: w * 0.133,
                ),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.021),
                  child: Text(
                    'Авторизация',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: AElevatedButtonExtended(
                  text: 'Войти',
                  onPressed: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                    var code = await adminController.auth();
                    if (code == 200) {
                      Get.back();
                      Get.to(() => const KeycloakLogin());
                    } else {
                      Get.back();
                      Get.snackbar('Ошибка', 'Status code: $code');
                    }
                  },
                ),
              ),
              const SizedBox(),
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
