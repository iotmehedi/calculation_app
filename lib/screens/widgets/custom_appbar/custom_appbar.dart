import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: globalText20(text: title, alignment: Alignment.center),
      leading: onBackPressed != null
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
