import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_admin/controllers/admin_controller.dart';

class KeycloakLogin extends StatefulWidget {
  const KeycloakLogin({super.key});

  @override
  State<KeycloakLogin> createState() => _KeycloakLoginState();
}

class _KeycloakLoginState extends State<KeycloakLogin> {
  var email = '';
  var password = '';
  var isHoverSign = false;
  var isHoverReg = false;

  var adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/keycloak-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: w * 0.007,
                            left: w * 0.021,
                            right: w * 0.021,
                            bottom: w * 0.021,
                          ),
                          child: Text(
                            'ASSISTANT-APP',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 30,
                                      letterSpacing: 2.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.025),
                      child: Column(
                        children: [
                          Container(
                            height: 3.0,
                            width: 500.0,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 102, 204),
                            ),
                          ),
                          Container(
                            width: 500.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 35.0),
                                  child: Text(
                                    'Sign in to your account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w100,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, bottom: 5.0),
                                    child: Text(
                                      'Email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 11,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: LoginTextField(
                                    onChanged: (p0) => email = p0,
                                    enabled: true,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Это поле должно быть заполнено';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, bottom: 5.0),
                                    child: Text(
                                      'Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 11,
                                          ),
                                    ),
                                  ),
                                ),
                                LoginTextField(
                                  passwordField: true,
                                  onChanged: (p0) => password = p0,
                                  enabled: true,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Это поле должно быть заполнено';
                                    }
                                    if (value.length > 100) {
                                      return 'Пароль должен содержать до 100 символов';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, bottom: 20.0),
                                  child: InkWell(
                                    child: Container(
                                      width: 400.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: isHoverReg
                                            ? const Color.fromARGB(
                                                255, 0, 64, 128)
                                            : const Color.fromARGB(
                                                255, 0, 102, 204),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sign In',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      if (validateLogin(email) == null &&
                                          validatePassword(password) == null) {
                                        if (Hive.box('user').get('password') !=
                                                null &&
                                            password ==
                                                Hive.box('user')
                                                    .get('password') &&
                                            Hive.box('user').get('login') !=
                                                null &&
                                            email ==
                                                Hive.box('user').get('login')) {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          );
                                          // await adminController.authPost(
                                          //     email, password);
                                          // await adminController.authToken(
                                          //     email, password);
                                          await Hive.box('user')
                                              .put('login', email);
                                          await Hive.box('user')
                                              .put('password', password);
                                          await Hive.box('user')
                                              .put('isLogged', true);
                                          await Hive.box('settings')
                                              .put('initial_screen', '/users');
                                          Get.back();
                                          Get.offAllNamed('/users');
                                        } else {
                                          showAlertDialog(context,
                                              'Данные указаны неверно');
                                        }
                                      } else {
                                        if (validateLogin(email) != null) {
                                          showAlertDialog(context,
                                              '${validateLogin(email)}\n');
                                        } else {
                                          showAlertDialog(context,
                                              '${validatePassword(password)}\n');
                                        }
                                      }
                                    },
                                    onHover: (val) {
                                      setState(() {
                                        isHoverReg = val;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 500.0,
                            height: 50.0,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 240, 240, 240),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    'New user?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 13,
                                          color: const Color.fromARGB(
                                              255, 114, 118, 123),
                                        ),
                                  ),
                                ),
                                InkWell(
                                  child: Text(
                                    'Register',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 13,
                                          decoration: isHoverSign
                                              ? TextDecoration.underline
                                              : null,
                                          color: const Color.fromARGB(
                                              255, 0, 136, 206),
                                        ),
                                  ),
                                  onTap: () {},
                                  onHover: (val) {
                                    setState(() {
                                      isHoverSign = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // AElevatedButtonExtended(
              //   text: 'Войти',
              //   onPressed: () async {
              //     if (validateLogin(email) == null &&
              //         validatePassword(password) == null) {
              //       if (Hive.box('user').get('password') != null &&
              //           password == Hive.box('user').get('password') &&
              //           Hive.box('user').get('login') != null &&
              //           email == Hive.box('user').get('login')) {
              //         showDialog(
              //           barrierDismissible: false,
              //           context: context,
              //           builder: (context) {
              //             return const Center(
              //                 child: CircularProgressIndicator());
              //           },
              //         );
              //         await adminController.authPost(email, password);
              //         await adminController.authToken(email, password);
              //         await Hive.box('user').put('login', email);
              //         await Hive.box('user').put('password', password);
              //         await Hive.box('user').put('isLogged', true);
              //         await Hive.box('settings')
              //             .put('initial_screen', '/users');
              //         Get.back();
              //         Get.offAllNamed('/users');
              //       } else {
              //         showAlertDialog(context, 'Данные указаны неверно');
              //       }
              //     } else {
              //       if (validateLogin(email) != null) {
              //         showAlertDialog(context, '${validateLogin(email)}\n');
              //       } else {
              //         showAlertDialog(
              //             context, '${validatePassword(password)}\n');
              //       }
              //     }
              //   },
              // ),
              const SizedBox(
                height: 250.0,
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
    this.text,
    this.suffixIcon,
    this.onChanged,
    required this.enabled,
    this.validator,
    this.passwordField = false,
    this.width,
  });
  final String? text;
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
    return Container(
      width: 400.0,
      height: 35.0,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        autocorrect: !widget.passwordField,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.passwordField ? !isVisible : false,
        enabled: widget.enabled,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 18, color: Colors.black),
        cursorColor: Colors.black,
        cursorWidth: 1.0,
        decoration: InputDecoration(
          hintText: widget.text ?? '',
          hintStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 18, color: Colors.black),
          contentPadding:
              const EdgeInsets.only(top: 12.0, left: 6.0, right: 6.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 229, 151, 0),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              width: 0.1,
            ),
          ),
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
