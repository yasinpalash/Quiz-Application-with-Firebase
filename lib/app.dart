import 'package:flutter/material.dart';
import 'package:quizapp/admin/admin_screen/login_screen.dart';
import 'package:quizapp/screens/home_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
