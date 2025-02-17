import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/chats/screens/creators.dart';
import '../../model/user_model.dart';

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

class UserData {
  static User? currentUser; // Global variable to store user data

  static void setUser(User user) {
    currentUser = user;
  }

  static User? getUser() {
    return currentUser;
  }
}
