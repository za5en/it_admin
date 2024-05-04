import 'package:flutter/material.dart';

import 'a_pop_up.dart';
import 'a_svg_icon.dart';

class ParamWithDropDown extends StatefulWidget {
  const ParamWithDropDown({
    super.key,
    required this.popupMenuButton,
    required this.popupMenuData,
    this.popupSize,
    this.onSelected,
  });
  final Widget popupMenuButton;
  final double? popupSize;
  final List<APopupMenuData> popupMenuData;
  final void Function(dynamic)? onSelected;

  @override
  ParamWithDropDownState createState() => ParamWithDropDownState();
}

class ParamWithDropDownState extends State<ParamWithDropDown> {
  Widget? popUpMenuWidget;
  @override
  void initState() {
    popUpMenuWidget = widget.popupMenuButton;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: PopupMenu(
        onSelected: (value) {
          setState(() {
            if (widget.popupMenuData[value].displayWidget != null) {
              popUpMenuWidget = widget.popupMenuData[value].displayWidget ??
                  widget.popupMenuData[value].child;
            } else {
              popUpMenuWidget = widget.popupMenuData[value].child;
            }
          });
          if (widget.onSelected != null) {
            widget.onSelected!(value);
          }
        },
        size: widget.popupSize,
        data: widget.popupMenuData,
        icon: widget.popupMenuButton,
      ),
    );
  }
}

class PopupMenu extends StatefulWidget {
  final List<APopupMenuData> data;
  final Widget? icon;
  final double? size;
  final void Function(dynamic)? onSelected;
  const PopupMenu(
      {super.key,
      required this.data,
      required this.icon,
      this.size,
      this.onSelected});

  @override
  PopupMenuState createState() => PopupMenuState();
}

class PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: widget.onSelected,
      elevation: 3,
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.zero,
      iconSize: 25,
      itemBuilder: (BuildContext context) {
        var result = widget.data.asMap().entries.map((e) => _getPopupMenuItem(
            context,
            e.value.iconData,
            e.value.child,
            e.value.onTap,
            widget.size,
            e.key));
        return result.toList();
      },
      child: widget.icon,
    );
  }
}

PopupMenuItem _getPopupMenuItem(BuildContext context, String? icon,
        Widget child, Function()? onTap, double? size, int value) =>
    PopupMenuItem(
      onTap: onTap,
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size ?? 100,
            child: child,
          ),
          icon != null
              ? ASvgIcon(
                  assetName: icon,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  height: 30,
                )
              : Container(),
        ],
      ),
    );
