import 'package:flutter/cupertino.dart';

extension EmptyPadding on num {
  ///Extension for padding vertically
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );

  ///Extension for padding horizontally
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}
