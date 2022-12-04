import 'package:flutter/material.dart';

import 'package:finalproject/pages/login_page.dart';
import 'package:finalproject/constant/app_constant.dart';
import 'package:finalproject/pages/home_page.dart';
import 'package:finalproject/pages/logbook_page.dart';

void main() {
  runApp((MaterialApp(
    title: 'Flutter App',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xffcd9d63),
      primaryColor: const Color(0xffcd9d63),
    ),
    routes: {
      AppConstants.loginPageRoute: (context) => LoginPage(),
      AppConstants.signUpPageRoute: (context) => const LogBook(),
      AppConstants.homePageRoute: (context) => Home(),
    },
  )));
}
