import 'package:flutter/material.dart';
import '../models/_models.dart';

Color getColorForImportance(Importance imp) {
  switch (imp) {
    case Importance.low:
      return const Color(0xFF00D930);
    case Importance.medium:
      return const Color(0xFFD9D930);
    case Importance.high:
      return const Color(0xFFD90030);
    default:
      return Colors.grey;
  }
}
