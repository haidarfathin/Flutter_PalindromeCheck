import 'package:flutter/material.dart';
import 'package:test_mobile_intern/screens/firstscreen.dart';
import 'package:test_mobile_intern/screens/secondscreen.dart';
import 'package:test_mobile_intern/screens/thirdscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        SecondScreen.routeName: (context) => const SecondScreen(),
        ThirdScreen.routeName: (context) => const ThirdScreen(),
      },
    );
  }
}
