import 'package:client_quiz_app/module/auth/screen/login.screen.dart';
import 'package:client_quiz_app/module/home/screen/home.page.dart';
import 'package:flutter/material.dart';

import 'common/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: kLogin,
      routes: {
        kLogin: (context) => const LoginPage(),
        kHome: (context) => const HomePage()
      },
    );
  }
}
