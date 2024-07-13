import 'package:flutter/material.dart';

import '../../../core/utils/consts/app_colors.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  const CustomIconWidget(
      {super.key, required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 16,
      color: color ?? AppColors.suffixIconColor,
    );
  }
}
