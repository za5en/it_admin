import 'package:flutter/material.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar(
      {super.key,
      this.title,
      this.leading,
      this.actions,
      this.size,
      this.toolbarHeight,
      this.nonDefWidth,
      this.backgroundColor});
  final Widget? title;
  final Widget? leading;
  final double? size;
  final double? toolbarHeight;
  final List<Widget>? actions;
  final bool? nonDefWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      leading: leading,
      toolbarHeight: toolbarHeight,
      actions: actions,
      leadingWidth: nonDefWidth != null ? 200 : null,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? 70);
}
