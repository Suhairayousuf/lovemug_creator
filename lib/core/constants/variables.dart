import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var height;
var width;
TextStyle poppinsTextStyle({double fontSize = 14.0, FontWeight fontWeight = FontWeight.normal, Color color = Colors.black}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}