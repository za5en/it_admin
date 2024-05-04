import 'package:flutter/material.dart';

class APopupMenuData {
  final String? iconData;
  final Widget child;
  final void Function()? onTap;
  final Widget? displayWidget;

  const APopupMenuData(
      {this.iconData, required this.child, this.onTap, this.displayWidget});
}
