import 'package:flexpay/constant/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Hero(
            tag: 'logoText',
            child: Material(
                color: Colors.transparent,
                child: Text('FlexPay', style: whiteFontStyle(fontSize: 20, fontWeight: FontWeight.bold),))),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
