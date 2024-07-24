import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final String? fontFamily;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.fontFamily
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:
             TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily ?? "Poppins", fontSize: 20,),
      ),
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
