import 'package:flexpay/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppUi {
   static nothing(){
    return const SizedBox.shrink();
   }

  static showLoading() {
       return CircularProgressIndicator(color: circularProgressColor,);
    }
   static void showToast({
     required String message,
     Color backgroundColor = Colors.black,
     Color textColor = Colors.white,
     ToastGravity gravity = ToastGravity.TOP,
     int timeInSecForIosWeb = 1,
     double fontSize = 16.0,
     Toast toastLength = Toast.LENGTH_SHORT,
   }) {Fluttertoast.showToast(
       msg: message,
       toastLength: toastLength,
       gravity: gravity,
       timeInSecForIosWeb: timeInSecForIosWeb,
       backgroundColor: backgroundColor,
       textColor: textColor,
       fontSize: fontSize,
     );}
   static void cancelToast() {Fluttertoast.cancel();}
  static void showSnackBar({
     required String title,
     required String message,
     bool isError = true,
     SnackPosition position = SnackPosition.TOP,
     Color textColor = Colors.white,
     Duration duration = const Duration(seconds: 2),
     SnackStyle snackStyle = SnackStyle.FLOATING,
     IconData? icon,
   }) {
     Get.snackbar(
       title,
       message,
       snackPosition: position,
       backgroundColor: isError ? Colors.red : Colors.green,
       colorText: textColor,
       duration: duration,
       snackStyle: snackStyle,
       icon: isError? Icon(Icons.warning_rounded, color: textColor) : Icon(Icons.check_circle_rounded, color: textColor),
     );
   }

}