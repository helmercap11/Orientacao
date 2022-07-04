import 'package:flutter/material.dart';
import 'package:orientacao/screens/home_page/home_page.dart';
import 'package:orientacao/screens/login_page/login_page.dart';
import 'package:orientacao/screens/splash_page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orientação Profissional',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

