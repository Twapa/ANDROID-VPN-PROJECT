

import 'package:androidproject/screens/home_page.dart';
import 'package:androidproject/utils/custom_theme.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

///entrance for the Application
///Stateless widget as parent widget for building the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'project vpn',
      debugShowCheckedModeBanner: false,
      theme: customLightTheme(context),
      darkTheme: customDarkTheme(context),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
