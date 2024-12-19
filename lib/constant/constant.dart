import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Color primaryColor = const Color(0xff152e5a);
Color secondaryColor = const Color(0xff17e7c6);
Color greyColor = const Color(0xff707070);
Color whiteColor = const Color(0xffffffff);
Color blackColor = Colors.black;
Color appBgColor = whiteColor;
Color textFieldBorderColor = Colors.blue;
Color textFieldFillColor = whiteColor;
Color circularProgressColor = whiteColor;

List<Color> kGradientColors = [const Color(0xff05aff7), const Color(0xff08aaf4), const Color(0xff17d0e1), const Color(0xff19e0d1), const Color(0xff11f3ce)];
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
String userCollectionName = 'users';


double kAppPadding = 16.0;
double kAppRadius = 8.0;
double kAppBarFontSize = 18.0;
double kAppFontSize = 14.0;
double kAppHeadingFontSize = 16.0;

extension CustomSizeBox on int {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension DismissKeyboard on BuildContext {
  void dismissKeyboard() {
    FocusScope.of(this).unfocus();
  }
}


Size get kSize => MediaQuery.of(Get.context!).size;

TextStyle kFontStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

TextStyle blackFontStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    color: Colors.black,
    fontWeight: fontWeight,
  );
}

TextStyle greyFontStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    color: greyColor,
    fontWeight: fontWeight,
  );
}

TextStyle whiteFontStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    color: Colors.white,
    fontWeight: fontWeight,
  );
}

TextStyle customFontStyle({double fontSize = 14, FontWeight fontWeight = FontWeight.normal, required Color color}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
  );
}
