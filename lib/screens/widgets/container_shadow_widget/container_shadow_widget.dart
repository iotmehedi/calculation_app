import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ContainerShadowWidget extends StatelessWidget {
  final Widget widget;
  final double? margin;
  const ContainerShadowWidget({super.key, required this.widget, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: margin ?? 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: HexColor("F3F3F3")),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x07101010),
            blurRadius: 45,
            offset: Offset(0, 8),
            spreadRadius: 0,
          )
        ],
      ),
    child: widget,
    );
  }
}
