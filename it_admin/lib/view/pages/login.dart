import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_admin/controllers/admin_controller.dart';
// import 'package:it_admin/view/pages/auth.dart';

import '../widgets/a_elevated_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = '';
  var password = '';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(w * 0.021),
                          child: Text(
                            'Авторизация',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginTextField(
                            text: 'Email или логин',
                            onChanged: (p0) => email = p0,
                            enabled: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Это поле должно быть заполнено';
                              }
                              return null;
                            },
                          ),
                          LoginTextField(
                            passwordField: true,
                            text: 'Пароль',
                            onChanged: (p0) => password = p0,
                            enabled: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Это поле должно быть заполнено';
                              }
                              if (value.length < 6) {
                                return 'Пароль должен содержать как минимум 6 символов';
                              }
                              if (value.length > 100) {
                                return 'Пароль должен содержать до 100 символов';
                              }
                              if (!value.isValidPassword()) {
                                return 'Пароль должен содержать латинские буквы, цифры и специальные символы (!@#\$&*~_-)';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AElevatedButtonExtended(
                text: 'Войти',
                onPressed: () async {
                  if (validateLogin(email) == null &&
                      validatePassword(password) == null) {
                    if (Hive.box('user').get('password') != null &&
                        password == Hive.box('user').get('password') &&
                        Hive.box('user').get('login') != null &&
                        email == Hive.box('user').get('login')) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      await adminController.authPost(email, password);
                      await adminController.authToken(email, password);
                      await Hive.box('user').put('login', email);
                      await Hive.box('user').put('password', password);
                      await Hive.box('user').put('isLogged', true);
                      await Hive.box('settings')
                          .put('initial_screen', '/users');
                      Get.back();
                      Get.offAllNamed('/users');
                    } else {
                      showAlertDialog(context, 'Данные указаны неверно');
                    }
                  } else {
                    if (validateLogin(email) != null) {
                      showAlertDialog(context, '${validateLogin(email)}\n');
                    } else {
                      showAlertDialog(
                          context, '${validatePassword(password)}\n');
                    }
                  }
                },
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

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.text,
    this.suffixIcon,
    this.onChanged,
    required this.enabled,
    this.validator,
    this.passwordField = false,
    this.width,
  });
  final String text;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool enabled;
  final String? Function(String?)? validator;
  final bool passwordField;
  final double? width;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  var isVisible = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: w * 0.007),
      margin: EdgeInsets.symmetric(vertical: w * 0.008),
      width: widget.width ?? w * 0.45,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      child: TextFormField(
        autocorrect: !widget.passwordField,
        enableSuggestions: !widget.passwordField,
        obscureText: widget.passwordField ? !isVisible : false,
        enabled: widget.enabled,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle:
              Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
          border: InputBorder.none,
          suffixIcon: widget.passwordField
              ? InkWell(
                  child: isVisible
                      ? Icon(Icons.remove_red_eye_rounded,
                          color:
                              Theme.of(context).textTheme.headlineMedium!.color)
                      : Icon(Icons.remove_red_eye_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .color),
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

void showAlertDialog(BuildContext context, String message) {
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

  Widget alertDialog = AlertDialog(
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
    content: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      getButton('Понятно', () {
        Navigator.pop(context);
      }),
    ]),
    actionsAlignment: MainAxisAlignment.spaceAround,
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

extension Validator on String {
  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{5,}$')
        .hasMatch(this);
  }
}

String? validateLogin(String? login) {
  if (login == null) {
    return 'Это поле должно быть заполнено';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null) {
    return 'Это поле должно быть заполнено';
  }
  if (password.length < 5) {
    return 'Пароль должен содержать как минимум 5 символов';
  }
  if (password.length > 100) {
    return 'Пароль должен содержать до 100 символов';
  }
  // if (!password.isValidPassword()) {
  //   return 'Пароль должен содержать латинские буквы, цифры и специальные символы (!@#\$&*~_-)';
  // }
  return null;
}
