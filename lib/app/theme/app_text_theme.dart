import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'package:flutter/material.dart';


textStyleWithRoboto({
  required colors,
  required FontWeight fontWeight,
  required double fontSize,
  dynamic decoration,
}) {
  return GoogleFonts.roboto(
    color: colors,
    fontWeight: fontWeight,
    fontSize: fontSize,
    decoration: decoration,
  );
}
