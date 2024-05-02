import 'package:flutter/material.dart';

class AElevatedButtonExtended extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  const AElevatedButtonExtended(
      {super.key,
      required this.text,
      required this.onPressed,
      this.padding,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                minimumSize: MaterialStatePropertyAll(
                  Size(MediaQuery.of(context).size.width * 0.536,
                      MediaQuery.of(context).size.width * 0.133),
                ),
              ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'OpenSans',
                ),
          ),
        ),
      ),
    );
  }
}
