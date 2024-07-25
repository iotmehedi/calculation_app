import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../custom_richtext/custom_richtext.dart';

class ShowResultValue extends StatelessWidget {
  final String value, title;
  const ShowResultValue({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: HexColor("0F182E"),
      child: Center(
        child: CustomRichText(
          title: "\$" + value,
          titleTextColor: HexColor("FFFFFFFF"),
          heading: title,
          headingTextColor: HexColor("6BDF74"),
        ),
      ),
    );
  }
}
