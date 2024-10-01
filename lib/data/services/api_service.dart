import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../model/resume.dart';


class ApiService {

  // Resume
  Future<List<Resume>> fetchResumeData() async {
    final String response = await rootBundle.loadString('assets/json/response-resume.json');
    final data = json.decode(response);
    List<Resume> resumeList = List<Resume>.from(data['data'].map((x) => Resume.fromJson(x)));
    return resumeList;
  }
}
