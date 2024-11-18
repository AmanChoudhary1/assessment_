import '../../data/repositories/assessment_repository.dart';

class GetAssessmentsUseCase {
  final AssessmentRepository repository;

  GetAssessmentsUseCase(this.repository);

  Future<Map<String, dynamic>> execute() async {
    return await repository.fetchAssessments();
  }
}
