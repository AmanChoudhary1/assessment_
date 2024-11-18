import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/assessment_model.dart';
import '../../domain/usecases/get_assessments_use_case.dart';
import 'assessment_event.dart';
import 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final GetAssessmentsUseCase repository;

  AssessmentBloc(this.repository) : super(AssessmentInitial()) {
    on<LoadAssessments>((event, emit) async {
      emit(AssessmentLoading());

      try {
        final data = await repository.execute();

        final categories = (data['categories'] as List)
            .map((item) => AssessmentModel.fromJson(item))
            .toList();

        final topPicks = (data['top_picks'] as List)
            .map((item) => TopPickModel.fromJson(item))
            .toList();

        final recentlyTaken = (data['recently_taken'] as List)
            .map((item) => RecentlyTakenModel.fromJson(item))
            .toList();

        emit(AssessmentLoaded(categories, topPicks, recentlyTaken));
      } catch (e) {
        emit(AssessmentError("Failed to load assessments"));
      }
    });
  }
}
