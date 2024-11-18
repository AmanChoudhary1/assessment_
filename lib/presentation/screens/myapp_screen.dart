import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../data/repositories/assessment_repository.dart';
import '../../domain/usecases/get_assessments_use_case.dart';
import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import 'home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final assessmentRepository = AssessmentRepository();
    final getAssessmentsUseCase = GetAssessmentsUseCase(assessmentRepository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: BlocProvider(
        create: (context) =>
            AssessmentBloc(getAssessmentsUseCase)..add(LoadAssessments()),
        child: const AssessmentScreen(),
      ),
    );
  }
}