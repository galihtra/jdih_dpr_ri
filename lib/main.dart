import 'package:flutter/material.dart';
import 'package:jdih_dpr_ri/screen/resume/resume_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JDIH DPR RI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResumeListScreen(), 
    );
  }
}
