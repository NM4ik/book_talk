import 'package:flutter/material.dart';

extension SizedExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  double get widthPx => mq.size.width;
}
