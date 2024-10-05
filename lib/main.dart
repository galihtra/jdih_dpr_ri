import 'package:flutter/material.dart';
import 'package:jdih_dpr_ri/screen/resume/resume_list_screen.dart';
import 'package:jdih_dpr_ri/screen/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JDIH DPR RI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        '/resume': (context) => ResumeListScreen(),
      },
    );
  }
}
