import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flexpay/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(()=> const LoginScreen(),transition: Transition.fadeIn, duration: const Duration(milliseconds: 1000));
      // Get.offAll(()=> const HomeScreen(),transition: Transition.fadeIn, duration: const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Column(
              children: [
                Hero(
                  tag: 'logoText',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'FlexPay',
                      style: whiteFontStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Your Digital DataBook',
                  style: whiteFontStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Center(
              child: Text(
                'Developed by: Jamshaid Malik',
                style: whiteFontStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
