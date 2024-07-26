import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1,color: HexColor("FAFAFA"),);
  }
}
