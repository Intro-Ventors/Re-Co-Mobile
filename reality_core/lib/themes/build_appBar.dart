import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    actions: [IconButton(onPressed: () {}, icon: const Icon(icon))],
  );
}
