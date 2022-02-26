

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.titleText = 'Your Title',
    required this.child,
    this.showAppBar = true,
    this.showDrawer = false,
    this.showAppBarActions = false,
    this.enableDarkMode = false,
   required this.drawerChild,
   required Widget bottomSheet,
  required  this.actions,
  })  : _bottomSheet = bottomSheet,
        super(key: key);

  final String titleText;
  final Widget child;
  final bool showAppBar;
  final bool showAppBarActions;
  final bool showDrawer;
  final bool enableDarkMode;
  final Widget drawerChild;
  final Widget _bottomSheet;
  final List<Widget> actions;

  static TextStyle get light => TextStyle(color:Colors.black);
  static TextStyle get dark => TextStyle(color:Colors.white);

  List<Widget> get _showActions {
    if (showAppBarActions) {
      return actions;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        actions: _showActions,
        title: Text("lati long", style: enableDarkMode ? dark : light),
      )
          : null,
      body: Container(
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        color: Colors.red,
        child: Text("tes"),),
      endDrawer: showDrawer ? drawerChild : null,
      bottomSheet: _bottomSheet,
    );
  }
}