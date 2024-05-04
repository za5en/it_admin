import 'package:flutter/material.dart';

class AElevatedButtonExtended extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final double? width;
  final bool? pad;
  const AElevatedButtonExtended(
      {super.key,
      required this.text,
      required this.onPressed,
      this.padding,
      this.backgroundColor,
      this.textColor,
      this.textSize,
      this.width,
      this.pad});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Container(
          height: 50,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Padding(
              padding: pad != null
                  ? const EdgeInsets.all(0.0)
                  : EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.015),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: textSize ?? 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
