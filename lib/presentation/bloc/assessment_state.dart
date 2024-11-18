import '../../data/models/assessment_model.dart';

abstract class AssessmentState {}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentLoaded extends AssessmentState {
  final List<AssessmentModel> categories;
  final List<TopPickModel> topPicks;
  final List<RecentlyTakenModel> recentlyTaken;

  AssessmentLoaded(this.categories, this.topPicks, this.recentlyTaken);
}

class AssessmentError extends AssessmentState {
  final String message;

  AssessmentError(this.message);
}
