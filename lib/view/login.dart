import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/widgets/buttonWidget.dart';
import 'package:flexpay/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryColor, primaryColor.withOpacity(0.2)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kAppPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: kSize.height * 0.2),
                  Hero(
                    tag: 'logoText',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'FlexPay',
                        textAlign: TextAlign.center,
                        style: whiteFontStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  10.h,
                  Text(
                    'Welcome to FlexPay',
                    textAlign: TextAlign.center,
                    style: whiteFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  40.h,
                  CustomTextField(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email, color: blackColor),
                  ),
                  20.h,
                  CustomTextField(
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.password, color: blackColor),
                  ),
                  40.h,

                  // Login Button
                  CustomButton(
                    color: primaryColor,
                    text: 'Login',
                    onPressed: () {

                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
