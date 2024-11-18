import 'dart:convert';
import 'package:flutter/services.dart';

class AssessmentRepository {
  Future<Map<String, dynamic>> fetchAssessments() async {
    final String response =
        await rootBundle.loadString('assets/assessments/assessments.json');

    return json.decode(response);
  }
}
