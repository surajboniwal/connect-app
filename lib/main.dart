import 'package:connect/presentation/screen/home/home_screen.dart';
import 'package:connect/presentation/screen/registration/registration_screen.dart';
import 'package:connect/presentation/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connect',
      theme: getMaterialTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: '/registration',
      routes: {
        '/': (context) => HomeScreen(),
        '/registration': (context) => RegistrationScreen(),
      },
    );
  }
}
