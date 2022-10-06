import 'package:flutter/material.dart';

CustomAppBar(
    {String title = '',
    BuildContext? pageContext,
    bool hideSearch = false,
    bool showBack = false,
    GlobalKey<ScaffoldState>? scaffoldKey}) {
  void searchAction() {
    Navigator.pushReplacementNamed(pageContext!, '/search');
  }

  IconButton drawerIcon = IconButton(
      onPressed: () {
        scaffoldKey!.currentState!.openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
        size: 30,
      ));
  IconButton backIcon = IconButton(
      onPressed: () {
        Navigator.pop(pageContext!);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 30,
      ));

  IconButton? leadingButton = drawerIcon;

  if (showBack) {
    leadingButton = backIcon;
  }

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Helvetica Neue')),
    leading: leadingButton,
    actions: [
      !hideSearch
          ? IconButton(
              onPressed: searchAction,
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ))
          : Container()
    ],
  );
}
