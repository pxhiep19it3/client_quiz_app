import 'package:client_quiz_app/module/auth/screen/login.screen.dart';
import 'package:client_quiz_app/module/quiz/screen/quiz.page.dart';
import 'package:flutter/material.dart';

import 'common/routes.dart';
import 'module/result/screen/result.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: kLogin,
      routes: {
        kLogin: (context) => const LoginPage(),
        kHome: (context) => const HomePage(),
        kResult: (context) => const ResultPage()
      },
    );
  }
}
